//
//  DetailView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/5/23.
//

import SwiftUI
import CoreLocation

struct DetailView: View {
    @EnvironmentObject var order: Order
    @EnvironmentObject private var viewModel : AuthViewModel
    @StateObject var homeModel = HomeViewModel()
    
    @Binding var show: Bool
    @State private var showingAlert = false
    var animation: Namespace.ID
    var party: Party
    
    var body: some View {
        ZStack {
            VStack(spacing: 15){
                Button{
                    withAnimation(.easeInOut(duration: 0.35)){
                        show = false
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .contentShape(Rectangle())
                     
                }
                .padding([.leading,.vertical], 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                // Party Preview
                GeometryReader{
                    let size = $0.size
                    HStack(spacing: 20){
                        Image(party.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width / 2, height: size.height + 30 )
                            .clipShape(CustomCorners(corners: [.topRight, .bottomRight], radius: 20))
                            
                        VStack(alignment: .leading, spacing: 8){
                            Text(party.title)
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text("Hosted By: \(party.host)")
                                .font(.callout)
                                .foregroundColor(.gray)
                            
                            RatingView(rating: party.rating)
                            
                            Button(action:{order.add(item: party);
                                viewModel.updateUserCart(party: party);
                                showingAlert = true}){
                                Text("Buy Ticket")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal,25)
                                    .padding(.vertical, 10)
                                    .background{Capsule().fill(Color.green.gradient)}
                                    .foregroundColor(.white)
                            }.alert("Cart Updated", isPresented: $showingAlert) {Button("OK", role: .cancel){}}
                        }
                    }
                }
                .frame(height: 220)
                Divider()
                    .padding(.top,40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background{
                Rectangle()
                    .fill(.white)
                    .ignoresSafeArea()
            }
            VStack(spacing: 35){
                //let destination = CLLocationCoordinate2D(latitude: party.latitude, longitude: party.longitude)

                MapViewRep(party: party, destination: CLLocationCoordinate2D(latitude: party.latitude, longitude: party.longitude))/////////////
                    .frame(width: 375, height: 150)
                    .cornerRadius(20)
                
                DirectionsActionButton(party: party)
                    .padding(.bottom,5)
            }
            .padding(.top,250)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
