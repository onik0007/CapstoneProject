//
//  menuView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//

import SwiftUI

struct menuView: View {
    @State private var toPay = false
    @State private var toLogin = false
    @State private var toContact = false
    @State private var toCart = false
    @State private var toPromo = false
    @EnvironmentObject private var viewModel : AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser{
            VStack(alignment: .leading,spacing: 10){
                Button(action: {self.toCart.toggle()}, label: {
                    HStack(spacing: 15){
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundColor(.pink)
                        Text("My Cart")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer(minLength: 0)
                    }.fullScreenCover(isPresented: $toCart){
                        //CartView(homeData: homeData)
                        CartView()
                            //.environmentObject(Party)
                    }
                }).padding(.top,100)
                Button(action: {self.toPromo.toggle()}, label: {
                    HStack(spacing: 15){
                        Image(systemName: "party.popper")
                            .font(.title)
                            .foregroundColor(.pink)
                        Text("Promote Your Party")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }.sheet(isPresented: $toPromo){
                        promoView()
                    }
                }).disabled(!user.promoter)
                    .opacity(user.promoter ? 1.0 : 0.5)
                
                Button(action: {self.toPay.toggle()}, label: {
                    HStack(spacing: 15){
                        Image(systemName: "creditcard")
                            .font(.title)
                            .foregroundColor(.pink)
                        Text("Add Card")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }.fullScreenCover(isPresented: $toPay){
                        //show party Menu
                        bankCardView()}
                })
                Button(action: {self.toContact.toggle()}, label: {
                    HStack(spacing: 15){
                        Image(systemName: "phone")
                            .font(.title)
                            .foregroundColor(.pink)
                        Text("Contact Us")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }.sheet(isPresented: $toContact){
                        //show party Menu
                        contactUsView()}
                })
                Spacer()
                Divider()
                HStack {
                    Spacer()
                    Button(action: {viewModel.signOut()})
                    {
                        HStack(spacing: 15){
                            Image(systemName: "arrow.backward.circle")
                                .font(.title)
                                .foregroundColor(.pink)
                            Text("Log out")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }.fullScreenCover(isPresented: $toLogin){
                        //show party Menu
                        LogoView()}
                    .padding([.bottom,.trailing],20)
                }//log out
            }
            .frame(width: UIScreen.main.bounds.width / 1.8)
            .background(Color.white.ignoresSafeArea())
            .cornerRadius(10)
        }
        
    }
}

struct menuView_Previews: PreviewProvider {
    static var previews: some View {
        //menuView(homedata: HomeViewModel())
        menuView()
    }
}
