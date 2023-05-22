//
//  promoView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 5/15/23.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var selected_numberOfPeople = 0 //
    @Published var selected_party_cost = "" //
    @Published var selected_party_Parking = ""
    @Published var selected_party_name = ""
    @Published var selected_theme = "Seasonal" //
    @Published var selected_parish = "Kingston" //
    @Published var selected_isHoliday = false //
    @Published var selected_wakeup = Date.now //
}
struct promoView: View {
    @StateObject private var userData = UserData()
    @State private var showSimalarityView: Bool = false
    @State var arr : [String] = []
    @Environment(\.presentationMode) var present
    @EnvironmentObject private var viewModel : AuthViewModel
    
    
    var parishes = ["Kingston", "St.Andrew", "Portland", "St.James", "St.Elizabeth", "St.Ann", "St.Mary", "Hanover", "St.Cathrine", "Clarendon", "Westmoreland", "Manchester", "St.Thomas", "Trelawny"]
    var party_types = ["Celebratory", "Family", "Seasonal", "Religious", "Food", "Bar", "Beach/Water", "Health", "Fashion/Costume", "Educational", "GovernmentSponsored", "JobFair","Charity"]
    var party_day = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    let minDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
    let maxDate = Calendar.current.date(byAdding: .year, value: +1, to: Date())!
        
    @State private var selectedDate = Date()
    @State private var isOutOfRange = false
    
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Essential Party Information")){
                    Picker("Party Theme", selection: $userData.selected_theme) {
                        ForEach(party_types, id: \.self) {
                            Text($0)
                        }
                    }//.pickerStyle(.wheel)
                    Picker("Location", selection: $userData.selected_parish) {
                        ForEach(parishes, id: \.self) {
                            Text($0)
                        }
                    }
                    Toggle("Holiday", isOn: $userData.selected_isHoliday)
                    TextField("Party Cost", text: $userData.selected_party_cost)
                        .keyboardType(.numberPad)
                    TextField("Party Name", text: $userData.selected_party_name)
                    HStack {
                        Spacer()
                        //
                        DatePicker(
                            "Event Day",
                            selection: $userData.selected_wakeup,
                            in: minDate...maxDate,
                            displayedComponents: .date
                        )
                        Spacer()
                    }
                }
                Section(header: Text("Optional Party Information")){
                    TextField("Number of Parking", text: $userData.selected_party_Parking)
                        .keyboardType(.numberPad)
                    
                    Picker("Number of Staff", selection: $userData.selected_numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
            }
            // show most simar event
            HStack{
                Button(action: {
                    viewModel.CreateEvent(party_name: userData.selected_party_name, isHoliday: userData.selected_isHoliday, party_cost: "\(userData.selected_party_cost)", party_attendees: userData.selected_numberOfPeople, party_parish: "\(userData.selected_parish )", party_theme: "\(userData.selected_theme)")
                    //let cost = (userData.selected_party_cost)
                    let newParty = Party(
                        id: UUID().uuidString,
                        image: "default_image",
                        offset: 0.0,
                        title: userData.selected_party_name,
                        host: viewModel.currentUser?.initials ?? "No Host",
                        rating: 0,
                        attendees: 0,
                        latitude: 17.9710,
                        longitude: -76.7936,
                        cost:  Int(userData.selected_party_cost) ?? 4500,
                        isHoliday: userData.selected_isHoliday,
                        quantity: 1,
                        party_parish: "Kingston",
                        
                        party_theme: "Dance",
                        isAdded: false,
                        day: "Saturday"
                    )
                    sampleParty.append(newParty)
                    present.wrappedValue.dismiss()
                }){
                    Text("Create Event")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 170, height: 40)
                        .background(Color.indigo)
                        .cornerRadius(15.0)
                }.disabled(!formIsValid) // error in syntax but works must be a bug in xcode
                                .opacity(formIsValid ? 1 : 0.5)
                            
                Button{
                    self.showSimalarityView.toggle()
                } label: {
                Text("Simalarity Check")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 170, height: 40)
                    .background(Color.indigo)
                    .cornerRadius(15.0)
                }.sheet(isPresented: $showSimalarityView){
                    CoSineIndex()//arr: arr)
                        .environmentObject(userData)
                }
            }
        }
    }
}
extension promoView: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !userData.selected_party_cost.isEmpty && !userData.selected_party_name.isEmpty
    }
}
struct promoView_Previews: PreviewProvider {
    static var previews: some View {
        promoView()
    }
}
