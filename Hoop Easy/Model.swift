//  Model.swift


import Foundation

class Model {
    
    struct User: Decodable {
        let id: Int
        let username: String
        let email: String
        let firstName: String
        let middleInitial: String
        let lastName: String
        let gamesAccepted: Int
        let gamesDenied: Int
        let gamesPlayed: Int
        let heightFt: Int?
        let heightInches: Int?
        let weight: Int?
        let overall: String
        let profilePic: String
    }
    
}
