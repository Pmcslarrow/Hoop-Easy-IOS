//
//  Map.swift
//  Hoop Easy
//
//  Created by Paul McSlarrow on 2/14/24.
//

import SwiftUI

struct Map: View {
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Map")
    }
}

#Preview {
    Map(viewModel: ViewModel())
}
