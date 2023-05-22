//
//  LogInView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//

import SwiftUI

/*final class sign_in_with_email_ViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
}*/

struct LogInView: View {
    @State private var toHomepage = false
    @State private var tosignUpForm = false
    @State var email = ""
    @State var password = ""
    @EnvironmentObject private var viewModel : AuthViewModel
    @StateObject var HomeModel = HomeViewModel()
    
    //@State private var username: String = ""
    //@State private var password: String = ""
    var body: some View {
        ZStack{
            
            //lGradient()
            Image("brickBackground")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.top, 50)
                Image("boredBunny")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 170, height: 260)
                    .clipped()
                    .cornerRadius(100)
                    .padding(.bottom, 40)
                TextField("Email",text: $email)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(15.0)
                    .padding(.bottom,20)
                SecureField("Password",text: $password)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(15.0)
                    .padding(.bottom,20)
                VStack {
                    HStack{
                        Button{
                            Task {
                                try await viewModel.signIn(withEmail:email, password:password)
                            }
                        }label: {
                            Text("LOGIN")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 180, height: 60)
                                .background(Color.blue)
                                .cornerRadius(15.0)
                        }.disabled(!formIsValid)
                            .opacity(formIsValid ? 1.0 : 0.5)
                        Button(action: {self.tosignUpForm.toggle()})
                        {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 180, height: 60)
                                .background(Color.red)
                                .cornerRadius(15.0)
                        }.sheet(isPresented: $tosignUpForm){
                            //show sign up form
                            signUpForm()
                        }
                    }
                }
            }
        }
    }
}
extension LogInView: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
