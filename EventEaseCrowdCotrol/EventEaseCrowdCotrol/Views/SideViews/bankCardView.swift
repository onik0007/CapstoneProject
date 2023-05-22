//
//  bankCardView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/7/23.
//

import SwiftUI

struct bankCardView: View {
    //@Binding var show: Bool
    @FocusState private var activeTF: ActivateKeybordField!
    @Environment(\.presentationMode) var present
    @EnvironmentObject private var viewModel : AuthViewModel
    
    @State private var cardNumber: String = ""
    @State private var cardHoldername: String = ""
    @State private var expireDate: String = ""
    @State private var cvvCode: String = ""
    @State private var toHome = false
    @State private var showingAlert = false
    //@State private var showPaymentView: Bool = false
    
    var body: some View {
        VStack{
            // Header view
            HStack{
                Button(action: {present.wrappedValue.dismiss()}, label: {
                    HStack(spacing: 15){
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.black)
                    }.fullScreenCover(isPresented: $toHome){
                        //show party Menu
                        HomePageView()}
                })
                Text("Add Card")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                
                Spacer(minLength: 0)
                Button(action: {
                    updateVariables()
                }, label: {
                    HStack(spacing: 15){
                        Image(systemName: "arrow.counterclockwise")
                            .font(.title2)
                            .foregroundColor(.black)
                    }.fullScreenCover(isPresented: $toHome){
                        //show party Menu
                        HomePageView()}
                })
            }
            CardView()
            Spacer(minLength: 0)
            Button{
                viewModel.updatePayment(card_num: cardNumber, card_cvv: cvvCode, card_holder_name: cardHoldername, exp_date: expireDate)
            } label: {
                Label("Add Card", systemImage: "lock")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.gray.gradient)
                    }
            }.alert("Card Successfully Added", isPresented: $showingAlert) {Button("OK", role: .cancel){}}
            .disableWithOpacity(cardNumber.count != 19 || expireDate.count != 5 || cardHoldername.isEmpty || cvvCode.count != 3)
        }
        .padding()
        
    }
    // Card view
    @ViewBuilder
    func CardView() -> some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [Color("c1"),Color("c2")], startPoint: .topLeading, endPoint: .bottomTrailing))
            //Card details
            VStack(spacing: 10){
                HStack {
                    TextField("XXXX XXXX XXXX XXXX", text: .init(get:{
                        cardNumber}, set: {value in
                        cardNumber = ""
                            
                            let startIndex = value.startIndex
                            for index in 0..<value.count{
                                let stringIndex = value.index(startIndex, offsetBy: index)
                                cardNumber += String(value[stringIndex])
                                if (index + 1) % 5 == 0 && value[stringIndex] != " " {
                                    cardNumber.insert(" ", at: stringIndex)
                                }
                            }
                            if value.last == " " {
                                cardNumber.removeLast()
                            }
                            // limiter to 16
                            cardNumber = String(cardNumber.prefix(19))
                    }))
                        .font(.title3)
                        .focused($activeTF, equals: .cardNumber)
                        .keyboardType(.numberPad)
                        
                    
                    Spacer(minLength: 0)
                    
                }
                HStack(spacing: 12){
                    TextField("MM/YY",text: .init(get: {
                        expireDate
                    }, set: {
                        value in
                        expireDate = value
                        if value.count == 3 && !value.contains("/") {
                            let startIndex = value.startIndex
                            let thirdPosition = value.index(startIndex, offsetBy: 2)
                            expireDate.insert("/", at: thirdPosition)
                        }
                        if value.last == "/" {
                            expireDate.removeLast()
                        }
                        expireDate = String(expireDate.prefix(5))
                    } ))
                        .focused($activeTF, equals: .expirationDate)
                        .keyboardType(.numberPad)
                        
                    
                    Spacer(minLength: 0)
                    
                    TextField("CVV", text: .init(get: {
                        cvvCode
                        
                    }, set: {
                        value in
                            cvvCode = value
                        cvvCode = String(cvvCode.prefix(3))
                    }))
                        .frame(width: 35)
                        .keyboardType(.numberPad)
                        .focused($activeTF, equals: .cvv)
                    
                    Image(systemName: "questionmark.circle.fill")
                }
                .padding(.top, 15)
                
                Spacer(minLength: 0)
                TextField("CARD HOLDER NAME", text: $cardHoldername)
                    .focused($activeTF, equals: .cardHolderName)
            }
            .padding(20)
            .environment(\.colorScheme, .dark)
            .tint(.white)
            
        }.frame(height: 200)
            .padding(.top, 35)
    }
    func updateVariables() {
            cardNumber = ""
            cardHoldername = ""
            cvvCode = ""
            expireDate = ""
    }
}

struct bankCardView_Previews: PreviewProvider {
    static var previews: some View {
        bankCardView()
    }
}

extension View {
    @ViewBuilder
    func disableWithOpacity(_ status: Bool) -> some View{
        self
            .disabled(status)
            .opacity(status ? 0.5: 1)
    }
}
