//
//  EventEaseCrowdCotrolApp.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//

import SwiftUI
import Firebase

@main
struct EventEaseCrowdCotrolApp: App {
    @StateObject var order = Order()
    @StateObject private var viewModel = AuthViewModel()
    @StateObject private var pvm = PromoViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
                LogoView()
                    .environmentObject(order)
                    .environmentObject(viewModel)
                    .environmentObject(pvm)
        }
    }
}
