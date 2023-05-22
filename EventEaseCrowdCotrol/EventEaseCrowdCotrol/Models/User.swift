//
//  User.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 5/14/23.
//

import Foundation
import SwiftUI

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    var password: String
    var promoter : Bool
    var username: String
    var birthday: Date
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

/*struct User: Identifiable,Hashable{
    //var id: ObjectIdentifier
    var id: String
    var name: String
    var password: String
    var promoter : Bool
    var party_preference: String
    var age: Int
    var username: String
   
}
var sampleuser: [User] = [
    User(id: "0", name: "Malli", password: "iamhuman2", promoter: true, party_preference: "Dancehall", age: 35, username: "wildlife4L"),
    User(id: "1", name: "Onik", password: "worldcat_2023", promoter: false, party_preference: "Soca", age: 25, username: "world_dawg12")
]
*/
