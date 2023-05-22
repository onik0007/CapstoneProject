//
//  ContentView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 5/14/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                HomePageView()
            }else{
                LogInView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
