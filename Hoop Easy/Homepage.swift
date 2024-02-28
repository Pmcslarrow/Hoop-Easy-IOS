//
//  Homepage.swift
//  Hoop Easy
//
//  Created by Paul McSlarrow on 2/13/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let myrtle = CLLocationCoordinate2D(latitude: 42.35, longitude: -71.06)
}

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

struct MapView: View {
    let viewModel: ViewModel
    @State private var position: MapCameraPosition = .automatic
    @State private var searchResults: [Model.CustomMapItem] = []
    @State private var selectedResult: Model.CustomMapItem?
    @State private var availableGames: [Model.Game] = []
    @State private var isMarkerClicked: Bool = false
    
    func handleMarkerClick() {
        if let selectedGame = selectedResult,
           let clickedGame = availableGames.first(where: { $0.gameID == selectedGame.gameID }) {
            self.viewModel.mapClickedGame = clickedGame
            self.isMarkerClicked = true
        }
    }

    var body: some View {
        Map(position: $position, selection: $selectedResult) {
            ForEach(self.searchResults, id: \.self) { game in
                Marker(item: game)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .onAppear {
            self.viewModel.getAvailableGames(completion: { games in
                if let games = games {
                    self.viewModel.availableGames = games
                    self.availableGames = games
                }
            }, MapKitGamesEscape: { mapItems in
                if let mapItems = mapItems {
                    self.searchResults = mapItems
                }
            })
        }
        .onChange(of: selectedResult) {
            handleMarkerClick()
        }
        .sheet(isPresented: $isMarkerClicked) {
            if let clickedGame = self.viewModel.mapClickedGame {
                Text(clickedGame.address)
                    .presentationDetents([.medium, .large])
            }
        }.ignoresSafeArea()
    }
}

struct NearbyGamesList: View {
    let viewModel: ViewModel
    @State private var isActive: Bool = false
    
    struct ListItem: View {
        let game: Model.Game
        
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
        }
    }


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
                    ForEach(self.viewModel.availableGames!) { game in
                        ListItem(game: game)
                    }
                }.listStyle(.plain)
            }
            .presentationDetents([.medium, .large])
        }
    }
}



#Preview {
    Homepage(viewModel: ViewModel())
}

/**
 OUTLINE OF APP:
 
 * * * Home Page  *  *  *
 The home page (that will be called "Games" on the tab view), is the primary way for
 a user to find games in a Tinder-like fashion, where they can either accept or deny the current opponent.
 
 The page will also have a section directly below this that lets the user see the details of when games are, and will navigate to a new tab when clicked on that will let each play submit the result of the game and accept it later on.
 
 
 * * * Profile Page  *  *  *
 Self-explanatory page. Contains profile information about the user, and will let them update every feature
 except for their email in use.
 
 
 * * * Map Page  *  *  *
 This is the alternative way of finding games that are closer to you. If you don't want to go through the Tinder-like game feed (or scroll view of games), then the user will be able to view a map containing all of the created games, and join accordingly.
 
 This will be done through the Google Maps API (Google Places) to help navigate around.
 
 
 * * * Rankings Page  *  *  *
 Simple query that will spit out the top ranked players in the world in a table-like fashion.
 
 
 **/

// Home "Games" ( the primary way of finding games in a Tinder-like deny and accept a challenger fashion ) -- figure.basketball or basketball

// Profile -- "person.fill" // "person"

// Map ( an alternate way to find games ) -- "map"

// Rankings -- "Crown"

