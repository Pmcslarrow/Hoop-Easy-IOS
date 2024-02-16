//
//  Rankings.swift
//  Hoop Easy
//
//  Created by Paul McSlarrow on 2/14/24.
//

import SwiftUI

struct Rankings: View {
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Rankings")
    }
}

#Preview {
    Rankings(viewModel: ViewModel())
}
