//
//  Extensions.swift
//  Hoop Easy
//
//  Created by Paul McSlarrow on 2/13/24.
//

import SwiftUI

struct Extensions: View {
    @State private var fakeState = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            
            Text("TextField Styling: ")
            TextField("Text Field", text: $fakeState).withInputStyling()
            Spacer()
            
            Text("Secure Field Styling: ")
            SecureField("Secure Field", text: $fakeState).withInputStyling()
            
            Spacer()
            
            Button {} label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
            }
            .withButtonStyling()
            
            
            Spacer()
        }
        
    }
}

extension TextField {
    func withInputStyling() -> some View {
        self.disableAutocorrection(true)
            .font(Font.body.bold())
            .padding(10)
            .background(.white)
            .border(.gray)
            .padding(.horizontal, 20)
            .foregroundColor(.black)
            .tint(.colorLightOrange)
            
    }
}

extension SecureField {
    func withInputStyling() -> some View {
        self.disableAutocorrection(true)
            .font(Font.body.bold())
            .padding(10)
            .background(.white)
            .border(.gray)
            .padding(.horizontal, 20)
            .foregroundColor(.black)
            .tint(.colorLightOrange)
            
    }
}

extension Button {
    func withButtonStyling() -> some View {
        self.background(.colorLightOrange)
            .padding(.horizontal, 20)
            .foregroundStyle(.white)
            .font(Font.body.bold())
    }
}

#Preview {
    Extensions()
}
