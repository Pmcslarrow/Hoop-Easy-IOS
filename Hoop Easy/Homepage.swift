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
    @State private var position: MapCameraPosition = .automatic
    @State private var searchResults: [MKMapItem] = []
    @State private var selectedResult: MKMapItem? // Renamed for clarity
    @State private var availableGames: [Model.Game] = []
    @State private var gameMarkers: [MKMapItem] = []
    
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Map(position: $position, selection: $selectedResult) {
            ForEach(self.availableGames, id: \.self) { game in
                let latitude = Double(game.latitude)
                let longitude = Double(game.longitude)
                if let latitude = latitude, let longitude = longitude {
                    Marker(item: MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))))
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .onAppear {
            self.viewModel.getAvailableGames() { value in
                if let games = value {
                    self.availableGames = games
                }
            }
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

