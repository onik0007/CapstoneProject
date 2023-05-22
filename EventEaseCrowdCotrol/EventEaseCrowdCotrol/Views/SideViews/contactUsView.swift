//
//  contactUsView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//


import SwiftUI

struct contactUsView: View {
    var body: some View {
        NavigationView{
            //Image(systemName: "arrow.left").resizable().frame(width: 10,height: 10)
            Form{
                Link("Call us", destination: NSURL(string: "tel://4048831063")! as URL)
                Link("Lets Party Website", destination: URL(string: "https://google.com")!)
                Link("Email Lets Party", destination: URL(string: "https://google.com")!)
            }
            .navigationBarTitle(Text("Contact Us"), displayMode: .inline)
        }
    }
}


struct contactUsView_preview: PreviewProvider {
    static var previews: some View {
        contactUsView()
    }
}
