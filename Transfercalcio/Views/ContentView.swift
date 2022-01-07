//
//  ContentView.swift
//  Transfercalcio
//
//  Created by Benjamin Lassmann on 06.01.22.
//

import SwiftUI

struct ContentView: View {
    let manager = ClubProfileManager()
    @State var club: Club?
    @State var header: Club?
   

    
    var body: some View {
        
        VStack{
            if let club = club {
                if let header = header {
                    ClubView(club: club, header: header)
                }
            } else {
                LoadingView().task {
                    do {
                        header = try await manager.getClubInformation(get: .header, clubID: "631")
                        club = try await manager.getClubInformation(get: .profile, clubID: "631")
                        
                    } catch {
                        print("error getting Club: \(error)")
                    }
                }
            }
            
        }
        .preferredColorScheme(.dark)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(club: previewClub, header: previewHeader)
    }
}
