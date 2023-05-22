//
//  CartView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/6/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var order: Order
    @Environment(\.presentationMode) var present
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 20){
                Button{present.wrappedValue.dismiss()
                }
                label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(.black)
                    
                }
                Text("My Cart")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
            }
            .padding()
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(spacing: 0){
                    ForEach(order.items){ item in
                        HStack {
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .cornerRadius(15)
                            VStack(alignment: .leading){
                                Text(item.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                Text(order.getPrice(value: Float(item.cost)))
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                HStack{
                                    Button(action: {
                                        //if item.quantity > 1 {item.quantity -= 1}
                                    }){
                                        Image(systemName: "minus")
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                    Text("\(item.quantity)")
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                        .padding(.vertical,5)
                                        .padding(.horizontal,10)
                                        .background(Color.black.opacity(0.06))
                                    Button(action: {
                                        //homeData.cartItems[homeData.getIndex(item: cart.item,isCartIndex: true)].quantity += 1
                                    }) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            HStack{
                Spacer()
                Button(action: {
                    
                }){
                 Text("Check out")
                     .font(.headline)
                     .foregroundColor(.white)
                     .padding()
                     .frame(width: 120, height: 40)
                     .background(Color.indigo)
                     .cornerRadius(15.0)
                }
                Spacer()
            }
             
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        //CartView(homeData: HomeViewModel())
        CartView()
            .environmentObject(Order())
        //HomePageView()
    }
}
