//
//  LoginPage.swift
//  Hoop Easy
//
//  Created by Paul McSlarrow on 2/13/24.
//

import SwiftUI

struct LoginPage: View {
    @ObservedObject private var viewModel = ViewModel()
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var navigateToHomepage = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("HoopEasyLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 264, height: 150)
                Spacer()
                
                TextField("",
                    text: $username,
                    prompt: Text("Username").foregroundStyle(.gray)
                ).withInputStyling()
                
                HStack {
                    SecureField("",
                                text: $password,
                                prompt: Text("Password").foregroundStyle(.gray)
                    ).withInputStyling()
                }
                
                Button {
                    viewModel.handleButtonClick(username: username, password: password)
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                }
                .withButtonStyling()
                
                Text(viewModel.loginAttempts > 0 ? "Failed to login" : "")
                
                Spacer()
                Spacer()
                
            }
            .onReceive(viewModel.$loggedIn) { loggedIn in
                navigateToHomepage = loggedIn
            }
            
            .navigationDestination(isPresented: $navigateToHomepage) {
                Homepage()
            }
        }
    }
}


#Preview {
    LoginPage()
}
