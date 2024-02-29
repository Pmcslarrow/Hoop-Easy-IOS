//
//  Homepage.swift
//  Hoop Easy
//
//  Created by Paul McSlarrow on 2/13/24.
//

import SwiftUI
import MapKit

/**
 The Homepage View is here to define the higher level structures that run the app.
 It separates the crucial components, starting with the View and then the NearbyGamesList
 and soon the CreateGame button
 
 - parameter viewModel: An ObservableObject that connects the entire application to the ViewModel. CRUCIAL.
 - returns: ATM a Map and NearbyGames List
 - warning: If you are starting here and walking through, just note that when adding functionality to stay within MVVM, such that you don't add a bunch of @State variables into the UI --> YUCK!!!!!!!
 */
struct Homepage: View {
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            MapView(viewModel: self.viewModel)
            NearbyGamesList(viewModel: self.viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding()
        }
   }
}

/**
 The MapView is arguably the most important component of the application.
 It interacts with the MapKit API such that we can interact with Apple Maps to find games in the area either directly on the map,
 or to interact with it through a list view, to later be sorted by the game's distance from the user!
 
 - parameter viewModel: An ObservableObject that connects the entire application to the ViewModel. CRUCIAL.
 - returns: The UI elements for the Map to function. It also keeps track of variables like $viewModel.selectedResult to see when a user clicks a new Marker on the map, and updates the UI accordingly
 - warning: Trust me to just leave the onTapGesture in the Map that sets  self.viewModel.isMarkerClicked = false. This makes sure that when you try to click out of the sheet, it works well. Otherwise you get lots of weird glitchy feelings in the UI
 
 
 # Notes: #
 When first implemented, I was not fully using the ViewModel to follow MVVM, and I was using state variables locally in the UI.
 This being said, I used confusing functions like getAvailableGames with two escaping callback functions. I think it would be wise and worth while to
 just let the function update the viewModel.availableGames and viewModel.searchResults directly inside the ViewModel's getAvailableGames function rather than trying to use
 completions
 */
struct MapView: View {
    @ObservedObject var viewModel: ViewModel
        
    func setupMapData() {
        self.viewModel.getAvailableGames(completion: { games in
            if let games = games {
                self.viewModel.availableGames = games
            }
        }, MapKitGamesEscape: { mapItems in
            if let mapItems = mapItems {
                self.viewModel.searchResults = mapItems
            }
        })
    }

    var body: some View {
        Map(position: $viewModel.position, selection: $viewModel.selectedResult) {
            ForEach(self.viewModel.searchResults, id: \.self) { game in
                Marker(item: game)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .onAppear {
            setupMapData()
        }
        .onChange(of: self.viewModel.selectedResult) {
            self.viewModel.handleMarkerClick()
        }
        .sheet(isPresented: $viewModel.isMarkerClicked) {
            if let clickedGame = self.viewModel.mapClickedGame {
                Text(clickedGame.address)
                    .presentationDetents([.medium, .large])
            }
        }.ignoresSafeArea()
        .onTapGesture {
            self.viewModel.isMarkerClicked = false
        }
    }
}


/**
 If a user wanted to look at the games sorted by how close they are to them, the list view can help make this process easier.
 It uses a plain vertical list that shows the games nearby and lets them click on a game to learn more about it.
 
 - parameter viewModel: I don't want to repeat...
 - returns: This UI holds the bullet list image at the bottom left corner of the screen. When clicked it toggles isActive to open the bottom drawer
 */
struct NearbyGamesList: View {
    let viewModel: ViewModel
    @State private var isActive: Bool = false
    
    var body: some View {
        Button(
            action: {
                isActive.toggle()
            },
            label: {
                Image(systemName: "list.bullet")
                    .foregroundStyle(.black)
                    .font(.system(size: 30))
            }
        ).sheet(isPresented: $isActive) {
            ZStack {
                List {
                    ForEach(Array(self.viewModel.availableGames!.enumerated()), id: \.offset) { index, game in
                        ListItem(viewModel: self.viewModel, game: game, mapMarker: self.viewModel.searchResults[index])
                    }
                }.listStyle(.plain)

            }
            .presentationDetents([.medium, .large])
        }
    }
}

/**
 
 This is the modularized design of an individual List Item about a game. The NearbyGamesList iterates through the list of available games, and then
 ListItem is a structure that actually shows the information about each, and lets the user choose more details about each game.
 
 - parameter viewModel: no.
 - parameter game: Type Model.Game and stores information about the individual game that is shows as a list item.
 - parameter mapMarker: Type Model.CustomMapItem which extends MKMapItem to utilize gameID as a unique identifier. The mapMarker is what lets us press an item in the list, and it changes in the MapView.

 - returns: An individual item in a list representing details about a game
 ```
 
 */
struct ListItem: View {
    let viewModel: ViewModel
    let game: Model.Game
    let mapMarker: Model.CustomMapItem

    var body: some View {
        HStack {
            Text("3.2 Mi")
                .font(.title)
                .foregroundStyle(.colorLightOrange)
                .fontWeight(.semibold)
            
            Spacer()
            
            VStack (alignment: .leading) {
                Text(game.address)
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                
                if let (date, time) = utcToLocal(time: game.dateOfGameInUTC) {
                    Text("\(date) \(time)")
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                }
            }
            
            Spacer()
            
            Image(systemName: "arrow.right.circle")
        }
        .padding()
        .onTapGesture {
            self.viewModel.selectedResult = mapMarker
            if let coordinate = mapMarker.placemark.location?.coordinate {
                self.viewModel.position = .region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                )
            }
        }
    }
}

#Preview {
    Homepage(viewModel: ViewModel())
}
