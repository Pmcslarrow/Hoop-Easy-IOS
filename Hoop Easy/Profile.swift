//
//  Profile.swift
//  Hoop Easy
//
//  Created by Paul McSlarrow on 2/14/24.
//

import SwiftUI

struct Profile: View {
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Profile")
    }
}

#Preview {
    Profile(viewModel: ViewModel())
}
