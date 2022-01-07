//
//  ClubView.swift
//  Transfercalcio
//
//  Created by Benjamin Lassmann on 06.01.22.
//

import SwiftUI
import Palette

struct ClubView: View {
    var club: Club
    var header: Club
    
    
    var body: some View{
        
        TabView{
            ZStack{
                VStack(alignment: .center) {
                    ClubHeaderView(club: club, header: header)
                        .frame(alignment: .top)
                    Spacer()
                    
                    List{
                        HStack{
                            Image(systemName: "map").frame(width: 20, alignment: .leading).foregroundColor(.blue)
                            Text("City")
                            Spacer()
                            Text(club.mainFacts!.city)
                                .bold()
                        }

                        HStack{
                            Image(systemName: "esim.fill").frame(width: 20, alignment: .leading).foregroundColor(.blue)
                            Text("Stadium")
                            Spacer()
                            Text(club.stadium?.name ?? "No Big Stadium")
                                .bold()
                        }
                        HStack{
                            Image(systemName: "eurosign.circle").frame(width: 20, alignment: .center).foregroundColor(.blue)
                            Text("Market Value")
                            Spacer()
                            Text("\(header.club?.marketValue ?? "-") €")
                                .bold()
                        }
                        HStack{
                            Image(systemName: "person").frame(width: 20, alignment: .center).foregroundColor(.blue)
                            Text("Manager")
                            Spacer()
                            Text(header.club?.coachName ?? "Coach")
                                .bold()
                        }
                        HStack{
                            Image(systemName: "person.2").frame(width: 20, alignment: .center).foregroundColor(.blue)
                            Text("Squad Size")
                            Spacer()
                            Text(club.mainFacts!.squadSize)
                                .bold()
                        }
                        HStack{
                            Image(systemName: "person.fill.questionmark").frame(width: 20, alignment: .center).foregroundColor(.blue)
                            Text("Avarge Age")
                            Spacer()
                            Text(Double(club.mainFacts!.avgAge)!.roundDouble())
                                .bold()
                        }
                        
                        HStack{
                            Image(systemName: "seal").frame(width: 20, alignment: .center).foregroundColor(.blue)
                            Text("Trophies")
                            Spacer()
                            Text("\(club.getTrophies())")
                                .bold()
                        }
                        HStack{
                            Image(systemName: "seal").frame(width: 20, alignment: .center).foregroundColor(.blue)
                            Text("Latest")
                            Spacer()
                            Text("\(club.getLatesetTrophy())")
                                .bold()
                        }

                    }
                    
                    
                    Spacer()


                }


            }
            .tabItem{
                Image(systemName: "flag")
                Text("Club")
            }
            
            
         
        }
        .preferredColorScheme(.dark)

    }
}

struct ClubView_Previews: PreviewProvider {
    static var previews: some View {
        ClubView(club: previewClub, header: previewHeader)
    }
}
