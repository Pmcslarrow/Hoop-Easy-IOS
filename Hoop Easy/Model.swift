//  Model.swift


import Foundation
import MapKit

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
    
    struct Game: Decodable, Hashable, Identifiable {
        let id = UUID()
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

        init(gameID: Int, userID: Int, address: String, longitude: String, latitude: String, dateOfGameInUTC: String, distance: String?, gameType: Int, playerCreatedID: String, timeOfGame: String, userTimeZone: String, status: String, teammates: [String: String], captains: [String: String]?, scores: [String: String]?, team1: [String: String]?, team2: [String: String]?, teamOneApproval: Int?, teamTwoApproval: Int?) {
            self.gameID = gameID
            self.userID = userID
            self.address = address
            self.longitude = longitude
            self.latitude = latitude
            self.dateOfGameInUTC = dateOfGameInUTC
            self.distance = distance
            self.gameType = gameType
            self.playerCreatedID = playerCreatedID
            self.timeOfGame = timeOfGame
            self.userTimeZone = userTimeZone
            self.status = status
            self.teammates = teammates
            self.captains = captains
            self.scores = scores
            self.team1 = team1
            self.team2 = team2
            self.teamOneApproval = teamOneApproval
            self.teamTwoApproval = teamTwoApproval
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(gameID)
            hasher.combine(userID)
        }
        
        static func == (lhs: Game, rhs: Game) -> Bool {
            return lhs.gameID == rhs.gameID && lhs.userID == rhs.userID
        }
    }
    
    class CustomMapItem: MKMapItem {
        var gameID: Int?
    }

    
}
