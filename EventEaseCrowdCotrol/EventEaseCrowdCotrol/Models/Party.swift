//
//  Party.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//

import SwiftUI

struct Party: Identifiable, Hashable, Codable{
    var id: String
    var image: String
    var offset: CGFloat
    var title: String
    var host: String
    var rating: Int
    var attendees: Int
    var latitude: CGFloat
    var longitude: CGFloat
    var cost : Int
    var isHoliday: Bool
    var quantity : Int
    var party_parish: String
    var party_theme :String
    var isAdded : Bool = false
    var day : String
}

var sampleParty: [Party] = [
    Party(id: "0", image: "uwi_carnival", offset: 0, title: "UWI Carnival", host: "Bobby", rating: 4, attendees: 1240, latitude: 18.4751 ,longitude: -77.8944, cost: 4500, isHoliday: true, quantity: 1, party_parish: "St.Andrew", party_theme: "Bar", day: "Saturday"),
   
    Party(id: "1", image: "sandz", offset: 0, title: "Sandz", host: "Shelly", rating: 5, attendees: 2680, latitude: 18.3000, longitude: -77.5000, cost: 3500, isHoliday: false, quantity: 1, party_parish: "Kingston", party_theme: "Seasonal",day: "Monday"),
   
    Party(id: "2", image: "i_love_soca", offset: 0, title: "I Love Soca", host: "Junior", rating: 3, attendees: 4250, latitude: 18.2683 ,longitude: -77.3472, cost: 6500, isHoliday: false, quantity: 1, party_parish: "Portland", party_theme: "Dance",day: "Sunday" ),
]
