//
//  LogoView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//

import SwiftUI

struct LogoView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack{
                Image("brickBackground")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        //Image(systemName: "moon.haze.fill")
                        Image(systemName: "bolt")
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                        Text("Crowd Control")
                            .font(Font.custom("Baskerville-Bold", size: 26))
                            .foregroundColor(.white.opacity(0.80))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
