//
//  Homepage.swift
//  Hoop Easy
//
//  Created by Paul McSlarrow on 2/13/24.
//

import SwiftUI

struct Homepage: View {
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 30) {
                        
                        GameCard(viewModel: self.viewModel)
                        GameCard(viewModel: self.viewModel)
                        GameCard(viewModel: self.viewModel)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
                Spacer()
                
                GameSwiper()
            }
            .navigationBarTitle("Confirmed Games")
        }
    }
}

struct NavigationBar: View {
    let viewModel: ViewModel
    
    var body: some View {
        TabView {
            Homepage(viewModel: self.viewModel)
                .tabItem {
                    Label("Games", systemImage: "person")
                }
                
            Map(viewModel: self.viewModel)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            Rankings(viewModel: self.viewModel)
                .tabItem {
                    Label("Rankings", systemImage: "crown")
                }
            Profile(viewModel: self.viewModel)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct GameCard: View {
    let viewModel: ViewModel
    //let cardDetails: Model.Game
    @State private var isAnimating = false

    
    var body: some View {
        NavigationLink(destination: GameDetail(viewModel: self.viewModel)) {
            ZStack {
                Rectangle()
                    .withCardStyling()
                    .scaleEffect(isAnimating ? 1.0 : 0.0)
                    .opacity(isAnimating ? 1.0 : 0.0)
                VStack {
                    ZStack {
                        Circle().withScrollTransition()
                        Image(systemName: "person.fill").withScrollTransition()
                    }
                    
                    HStack (spacing: 20){
                        Text("0.61 Miles").withScrollTransition()
                        Text("65 Ovr").withScrollTransition()
                    }.padding(.all)
                }
            }.onAppear {
                withAnimation(
                    .spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5)) {
                    self.isAnimating = true
                }
            }
            .onTapGesture {
                print(self.viewModel.availableGames ?? "Nothing in avail games")
            }
        }.buttonStyle(PlainButtonStyle())
    }
}


struct GameSwiper: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Text("Tinder Swipe Left and Right with Gestures!")
            }
            .navigationTitle("Find Games")
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

