//
//  NotificationView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/14/23.
//

import SwiftUI

//struct ProfileView: View {
struct ProfileView: View {
    @EnvironmentObject private var viewModel : AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser{
            List{
                Section{
                    HStack{
                        //Text(viewModel.currentUser!.initials)
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        Spacer()
                        VStack(alignment: .leading, spacing: 4){
                            Text(user.fullname)
                                .font(.system(size: 10))
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user.email)
                                .font(.system(size: 10))
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
                
                Section("General"){
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        Spacer()
                        Text("1.0.0")
                            .font(.system(size: 10))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Section("Account"){
                    Button{
                        viewModel.deleteAcc()
                    }label: {
                        SettingsRowView(imageName: "x.circle.fill", title: "Delete Account", tintColor: Color(.red))
                    }
                }
            }
            .padding(.top, 4)
                .frame(width: UIScreen.main.bounds.width / 1.8)
                .background(Color.white.ignoresSafeArea())
                .cornerRadius(10)
                //.padding(.top,100)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            //.environmentObject()
    }
}
