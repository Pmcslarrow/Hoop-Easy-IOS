//  ViewModel.swift


import Foundation
import FirebaseAuth

class ViewModel: ObservableObject {
    @Published var loggedIn = false
    @Published var loginAttempts = 0
    
    func handleButtonClick(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                strongSelf.loggedIn = false
                strongSelf.loginAttempts += 1
            } else {
                print("User \(authResult?.user.uid ?? "") successfully logged in")
                strongSelf.loggedIn = true
            }
        }
    }
}


