//
//  ClubHeader.swift
//  Transfercalcio
//
//  Created by Benjamin Lassmann on 07.01.22.
//

import SwiftUI

struct ClubHeaderView: View {
    let club: Club
    let header: Club

    
    
    var body: some View {
        let clubImage = AsyncImage(url: URL(string: club.additionalTeams![0].image)) {
            image in image
                .resizable()
                .aspectRatio( contentMode: .fit)
                .fixedSize(horizontal: true, vertical: true)
        } placeholder: {
            ProgressView()
        }
            .padding(.leading)
        
        HStack {
            // Image
            clubImage.scaleEffect(1)
            VStack(alignment: .leading) {
                Text(header.club?.name ?? "Default FC")
                    .font(.title)
                    .bold()
                Text("\(header.club?.rank ?? "99"). in \(header.club?.leagueName ?? " League")")
                    .font(.footnote)
            }
            .padding(.trailing)
            
        }
        
        .border(.blue)
    }
        
}

struct ClubHeader_Previews: PreviewProvider {
    static var previews: some View {
        ClubHeaderView(club: previewClub, header: previewHeader)
    }
}
