//  ViewModel.swift

import Foundation
import FirebaseAuth
import Alamofire
import MapKit

class ViewModel: ObservableObject {
    private var model = Model()
    var currentUser: Model.User?
    @Published var availableGames: [Model.Game]?
    @Published var loggedIn = false
    @Published var loginAttempts = 0
    
    func handleButtonClick(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            print("User \(authResult.user.uid) successfully logged in")
            
            callCurrentUser(endpoint: "api/getUser", params: ["email" : email.lowercased()]) { result in
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
            
            handleGettingAvailableGames()

            self.loggedIn = true
        } catch {
            print("Error signing in: \(error.localizedDescription)")
            self.loggedIn = false
            self.loginAttempts += 1
        }
    }
    
    func handleGettingAvailableGames() {
        callAvailableGames(endpoint: "api/games", params: ["" : ""]) { result in
            switch result {
            case .success(let games):
                if let games = games {
                    self.availableGames = games
                } else {
                    print("Games is nil")
                }
            case .failure(let error):
                print("API call failed [handleGettingAvailableGames()] :", error)
            }
        }
    }
    
    func getAvailableGames(completion: @escaping ([Model.Game]?) -> Void, MapKitGamesEscape: @escaping ([MKMapItem]?) -> Void) {
        callAvailableGames(endpoint: "api/games", params: ["": ""]) { result in
            switch result {
            case .success(let games):
                completion(games)
                
                // Create MKMapItems from game coordinates
                let MKGames = games?.compactMap { game -> MKMapItem? in
                    guard let latitude = Double(game.latitude),
                          let longitude = Double(game.longitude) else {
                        return nil
                    }
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let placemark = MKPlacemark(coordinate: coordinate)
                    let mapItem = MKMapItem(placemark: placemark)
                    mapItem.name = "\(game.gameType)v\(game.gameType) on \(game.dateOfGameInUTC.prefix(10))"
                    
                    return mapItem
                }
                MapKitGamesEscape(MKGames)
                
            case .failure(let error):
                print("Error fetching games: \(error)")
                completion(nil)
                MapKitGamesEscape(nil)
            }
        }
    }


   
    func callCurrentUser(endpoint: String, params: [String: String], completion: @escaping (Result<Model.User?, Error>) -> Void) {
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
    
    func callAvailableGames(endpoint: String, params: [String: String], completion: @escaping (Result<[Model.Game]?, Error>) -> Void) {
        let api = "https://hoop-easy-production.up.railway.app/" + endpoint

        AF.request(api, parameters: params).responseDecodable(of: [Model.Game].self) { response in
            switch response.result {
            case .success(let games):
                completion(.success(games))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }



}



