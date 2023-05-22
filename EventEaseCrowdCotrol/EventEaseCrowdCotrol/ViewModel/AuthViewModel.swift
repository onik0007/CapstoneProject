//
//  AuthViewModel.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 5/14/23.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol{
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    //let db = Firestore.firestore()
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }catch{
            print("DEBUG failed to log in with \(error.localizedDescription)")
        }
    }
    func createUser(withEmail email: String, password: String, fullName: String, username: String, partyPromoter: Bool, birthday: Date) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullName, email: email, password: password, promoter: partyPromoter, username: username, birthday: birthday)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch{
            print("Failed to create user \(error.localizedDescription)")
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG failed to sign out \(error.localizedDescription)")
        }
    }
    func deleteAcc() {
        //do{
        print("Delete user account")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).delete()
        self.userSession = nil
        //self.currentUser = nil
        /*}catch{
         print("DEBUG failed to Delete Account \(error.localizedDescription)")
         }*/
        
    }
    func fetchUser() async{
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    
    ///************************************************************************************************************************************************
    func fetchItems() {
        
        let db = Firestore.firestore()
        let itemsCollection = db.collection("items")
        
        itemsCollection.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            let items = documents.compactMap { document in
                let data = document.data()
                
                if let id = data["id"] as? String,
                   let title = data["party_title"] as? String,
                   let host = data["party_host"] as? String,
                   let cost = data["party_cost"] as? Int,
                   let attendee = data["party_attendees"] as? Int,
                   let rating = data["rating"] as? Int,
                   let latitude = data["party_location"] as? GeoPoint,
                   let longitude = data["party_location"] as? GeoPoint,
                   let theme = data["party_theme"] as? String,
                   let isHoliday = data["isHoliday"] as? Bool,
                   let day = data["party_day"] as? String
                {
                    return Party(id: id, image: "default_image", offset: 0, title: title, host: host, rating: rating, attendees: attendee, latitude: latitude.latitude, longitude: longitude.longitude, cost: cost, isHoliday: isHoliday, quantity: 0, party_parish: "Portland", party_theme: theme, day: day)
                }
                
                return nil
            }
        }
    }
    ///************************************************************************************************************************************************
    func updatePayment(card_num: String, card_cvv: String, card_holder_name:String, exp_date:String){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).setData(["card_number":card_num, "cardcvv" :card_cvv, "card_holder_name":card_holder_name, "exp_date":exp_date], merge: true)
    }
    func updateUserCart(party: Party){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).setData(["My Cart": [party.title, party.cost]], merge: true)
    }
    func CreateEvent(party_name:String, isHoliday:Bool, party_cost: String, party_attendees: Int, party_parish: String, party_theme: String){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("Items").document(uid).setData(["party_name": party_name, "isHoliday": isHoliday, "party_cost": party_cost, "party_attendees":party_attendees, "party_parish":party_parish, "party_theme": party_theme], merge: true)
    }
}
