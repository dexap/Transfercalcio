//
//  ClubManager.swift
//  Transfercalcio
//
//  Created by Benjamin Lassmann on 06.01.22.
//

import Foundation
import SwiftUI

enum getRequest: String {
    case profile = "get-profile"
    case header = "get-header-info"
}

class ClubProfileManager {
    
    func getClubInformation(get: getRequest ,clubID: String) async throws -> Club {
        guard let url = URL(string: "https://transfermarket.p.rapidapi.com/clubs/\(get.rawValue)?id=\(clubID)") else {fatalError("Missing URL")}

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("transfermarket.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        urlRequest.setValue("106f5b3a01mshaa222632dd44131p17cc4djsn9e2c7e927b93", forHTTPHeaderField: "x-rapidapi-key")

        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // print("---> data: \(String(data: data, encoding: .utf8)!)")
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("error fetching data")}
        
        print("Response Counter: \(response.value(forKey: "X-RateLimit-Requests-Remaining") ?? "error response counter")")

        let decodedData = try JSONDecoder().decode(Club.self, from: data)
        
        return decodedData
    }

}


struct Club: Decodable {
    
    var mainFacts: MainFacts?           // for profile
    var stadium: Stadium?               //
    var additionalTeams: [Teams]?       //
    var club: Club?                     // for header
    var successes: [Successes?]?
    var squad: Squad?
    
    
    // squad
    struct Squad: Decodable {
        
    }
    
    
    
    
    
    // header
    struct Club: Decodable {
        var rank: String?
        var name: String?
        var marketValue: String?
        var leagueName: String?
        var coachName: String?
    }
    
    // profile
    struct MainFacts: Decodable {
        var id: String
        var fullName: String
        var city: String
        var countryName: String
        var squadSize: String
        var avgAge: String
    }
    struct Stadium: Decodable {
        var id: String
        var name: String
        var totalCapacity: String
        var image: String
    }
    struct Teams: Decodable {
        var image: String
        var name: String
        var id: String
    }
    struct AdditionalData: Decodable{
        var seasonIds: [String?]
    }
    struct Successes: Decodable {
        var number: String?
        var name: String?
        var additionalData: AdditionalData
    }
    
    func getTrophies() -> Int {
        var count = 0
        
        successes?.forEach({ suc in
            count += Int(suc?.number ?? "0") ?? 0
        })
        
        return count
    }
    
    func getLatesetTrophy() -> String {
        var years: [String] = []
        
        successes?.forEach({ suc in
            suc?.additionalData.seasonIds.forEach({ season in
                years.append(season ?? "")
            })
        })
        let latest = years.max()
        
        var comp: String?
        
        successes?.forEach({ suc in
                suc?.additionalData.seasonIds.forEach({ season in
                if (season == latest){
                    comp = suc?.name ?? ""
                    }
                })
        })
        
        return comp ?? "none"
    }

    
}


