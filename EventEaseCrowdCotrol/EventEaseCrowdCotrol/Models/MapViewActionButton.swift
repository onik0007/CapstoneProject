//
//  MapViewActionButton.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//

import SwiftUI

struct MapViewActionButton: View {
    @State private var toHomepage = false
    @Environment(\.presentationMode) var present
    
    var body: some View {
        Button(action: {present.wrappedValue.dismiss()}){
            Image(systemName: "arrow.left")
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color:.black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .fullScreenCover(isPresented: $toHomepage){
            //show party Menu
            HomePageView()
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
