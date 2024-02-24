//
//  GameDetail.swift
//  Hoop Easy
//
//  Created by Paul McSlarrow on 2/15/24.
//

import SwiftUI

struct GameDetail: View {
    let viewModel: ViewModel
    @State var isSheetActive = false
    
    init (viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Image("background_2").withBackground() // Insert map ui
            
            VStack {
                Text("GameDetail.swift")
                Text("The game is already accepted, but the user needs to find the details about the game. This view should contain a map, and then a .sheet at the bottom that they have to look at address details and such. The map should work such that they can also grab the address as well. Best of luck")
            }
        }
    }
}


struct FindGameDetail: View {
    let viewModel: ViewModel
    @State var isSheetActive = false
    
    init (viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Image("background_2").withBackground() // Insert map ui
            
            VStack {
                Text("FindGameDetail")
            }
        }
    }
}


#Preview {
    GameDetail(viewModel: ViewModel())
}

