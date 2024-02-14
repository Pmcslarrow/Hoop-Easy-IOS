//  ViewModel.swift

import Foundation
import FirebaseAuth
import Alamofire

class ViewModel: ObservableObject {
    private var model = Model()
    var currentUser: Model.User?
    @Published var loggedIn = false
    @Published var loginAttempts = 0
    
    func handleButtonClick(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            print("User \(authResult.user.uid) successfully logged in")
            
            callApi(endpoint: "api/getUser", params: ["email" : email.lowercased()]) { result in
                switch result {
                case .success(let user):
                    if let user = user {
                        print(user)
                        self.currentUser = user
                    } else {
                        print("User is nil")
                    }
                case .failure(let error):
                    print("API call failed:", error)
                }
            }


            self.loggedIn = true
        } catch {
            print("Error signing in: \(error.localizedDescription)")
            self.loggedIn = false
            self.loginAttempts += 1
        }
    }
   
    func callApi(endpoint: String, params: [String: String], completion: @escaping (Result<Model.User?, Error>) -> Void) {
        let api = "https://hoop-easy-production.up.railway.app/" + endpoint

        AF.request(api, parameters: params).responseDecodable(of: Model.User.self) { response in
            switch response.result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCurrentUser() -> Void {
        print(self.currentUser!)
    }
     


}



