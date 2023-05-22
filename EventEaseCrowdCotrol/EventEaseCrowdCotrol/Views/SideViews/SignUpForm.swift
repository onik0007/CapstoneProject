//
//  SignUpForm.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//

import SwiftUI
import FirebaseAuth

struct signUpForm: View {
    //@Environment(\.presentationMode) var presentationMode
    @Environment(\.presentationMode) var presentationMode
    //@StateObject private var ViewModel = signUpViewModel()
    @EnvironmentObject private var viewModel : AuthViewModel
    
    @State private var fullName = ""
    @State private var birthday = Date()
    @State private var password = ""
    @State private var confirm_password = ""
    @State private var email = ""
    @State private var username = ""
   // @State private var partyRec = false
    @State private var partyPromoter = false
    @State private var login = false
    @State private var showingAlert = false
    // Define your date range
    let minDate = Calendar.current.date(byAdding: .year, value: -65, to: Date())!
    let maxDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        
    @State private var selectedDate = Date()
    @State private var isOutOfRange = false
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Personal Information")){
                        TextField("FullName", text: $fullName)
                    //
                        DatePicker(
                            "Birthday",
                            selection: $selectedDate,
                            in: minDate...maxDate,
                            displayedComponents: .date
                        ).onChange(of: selectedDate) { date in
                            // Perform any necessary actions when the date changes
                            print("Selected date: \(date)")
                            
                            // Check if the selected date is within the allowed range
                            isOutOfRange = date < minDate || date > maxDate
                        }
                        if isOutOfRange {
                            Text("Selected date is out of range.")
                                .foregroundColor(.red)
                        }
                    
                        
                    
                    //
                    //DatePicker("Birthdate", selection: $birthday, displayedComponents: .date)
                }
                Section(header: Text("Account Information")){
                    TextField("Email", text: $email).autocapitalization(.none)
                    TextField("Username", text: $username)
                    SecureField("Enter Password",text:$password)
                    ZStack(alignment: .trailing){
                        SecureField("Confirm Password",text:$confirm_password)
                        if !password.isEmpty && !confirm_password.isEmpty {
                            if password == confirm_password {
                                Image (systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            } else {
                                Image (systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor (Color ( .systemRed))
                            }
                        }
                    }
                    //Toggle("Party Reccomendations", isOn: $partyRec)
                    Toggle("Promoter", isOn: $partyPromoter)
                        
                }
            }.navigationTitle("Account")
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        
                        Button{
                            Task {
                                try await viewModel.createUser(withEmail:email, password:password, fullName:fullName, username: username, partyPromoter: partyPromoter, birthday: birthday)
                            }
                        }label:{
                            Text("Sign up")
                        }.disabled(formIsValid)
                            //.opacity(formIsValid ? 1.0 : 0.5)
                    }
                }
        }
        .accentColor(.green)
        .navigationBarHidden(true)
    }

}
extension signUpForm: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !fullName.contains(" ")
        && !fullName.isEmpty
        && !username.isEmpty
        && confirm_password == password
    }
}

struct signUpForm2_Previews: PreviewProvider {
    static var previews: some View {
        signUpForm()
    }
}
