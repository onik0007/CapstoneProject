//
//  DirectionsActionButton.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/6/23.
//

import SwiftUI
import CoreLocation

struct DirectionsActionButton: View {
    @State private var toHomepage = false
    var party: Party
    var body: some View {
        Button(action: {self.toHomepage.toggle()}){
            Text("Map Route")
                .font(.callout)
                .fontWeight(.semibold)
                .padding(.horizontal,35)
                .padding(.vertical, 10)
                .background{Capsule().fill(Color.blue.gradient)}
                .foregroundColor(.white)
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .fullScreenCover(isPresented: $toHomepage){
            //Show Map
            ZStack (alignment: .top){
                MapViewRep(party: party, destination: CLLocationCoordinate2D(latitude: party.latitude, longitude: party.longitude))//////
                    .ignoresSafeArea()
                MapViewActionButton()
                    .padding(.leading)
                    .padding(.top,4)
            }
        }
    }
}
