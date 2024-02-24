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
    
    struct Game: Decodable, Hashable {
        let gameID: Int
        let userID: Int
        let address: String
        let longitude: String
        let latitude: String
        let dateOfGameInUTC: String
        let distance: String?
        let gameType: Int
        let playerCreatedID: String
        let timeOfGame: String
        let userTimeZone: String
        let status: String
        let teammates: [String: String]
        let captains: [String: String]?
        let scores: [String: String]?
        let team1: [String: String]?
        let team2: [String: String]?
        let teamOneApproval: Int?
        let teamTwoApproval: Int?
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(gameID)
            hasher.combine(userID)
        }
        
        static func == (lhs: Game, rhs: Game) -> Bool {
            return lhs.gameID == rhs.gameID && lhs.userID == rhs.userID
        }
    }

    
}
