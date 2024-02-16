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
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    
                    GameCard(viewModel: ViewModel())
                    GameCard(viewModel: ViewModel())
                    GameCard(viewModel: ViewModel())
                    GameCard(viewModel: ViewModel())
                    GameCard(viewModel: ViewModel())
                    GameCard(viewModel: ViewModel())
                    GameCard(viewModel: ViewModel())
                    GameCard(viewModel: ViewModel())
                    GameCard(viewModel: ViewModel())

                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }

            Spacer()
        }.backgroundImage()
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

extension Rectangle {
    func withCardStyling() -> some View {
        self
            .fill(
                LinearGradient(gradient: Gradient(colors: [Color.white, .colorLightOrange]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            )
            .frame(width: 200, height: 215)
            .clipShape(.buttonBorder)
            .overlay(
                LinearGradient(gradient: Gradient(colors: [Color.colorLightOrange, Color.white]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .frame(width: 200, height: 215)
                    .clipShape(.buttonBorder)
                    .opacity(0.1) 
            )
            .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0.25)
                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
                    .blur(radius: phase.isIdentity ? 0 : 3)
            }
    }
}

extension Circle {
    func withScrollTransition() -> some View {
        self
            .frame(width: 120, height: 120)
            .opacity(0.1)
            .scrollTransition(.animated.threshold(.visible(1))) { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0.25)
                    .scaleEffect(phase.isIdentity ? 1 : 0.3)
                    .blur(radius: phase.isIdentity ? 0 : 3)
            }
    }
}

extension Text {
    func withScrollTransition() -> some View {
        self
            .font(.system(size: 16, weight: .bold))
            .scrollTransition(.animated.threshold(.visible(1))) { content, phase in
                content
                    .opacity(phase.isIdentity ? 0.5 : 0)
                    .blur(radius: phase.isIdentity ? 0 : 3)
        }
    }
}

extension Image {
    func withScrollTransition() -> some View {
        self
            .font(.system(size: 90))
            .scrollTransition(.animated.threshold(.visible(1))) { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0.0)
                    .scaleEffect(phase.isIdentity ? 1 : 0.3)
                    .blur(radius: phase.isIdentity ? 0 : 3)
            }
    }
    
    func withBackground() -> some View {
        self.resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
    }
}

struct BackgroundImageView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                Image("background_1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            )
    }
}
extension View {
    func backgroundImage() -> some View {
        self.modifier(BackgroundImageView())
    }
}




#Preview {
    Extensions()
}
