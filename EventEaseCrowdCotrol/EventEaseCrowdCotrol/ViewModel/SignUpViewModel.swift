//
//  SignUpViewModel.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 5/14/23.
//

import Foundation
import FirebaseAuth

enum FBError: Error, Identifiable{
    case error(String)
    
    var id: UUID{
        UUID()
    }
    var errorMessage: String {
        switch self {
        case .error(let message):
            return message
        }
    }
}

class signUpViewModel: ObservableObject{
    @Published var errorMessage : String?
    
    func signUp(email:String, password: String, username: String, completion: @escaping (Result<Bool, FBError>) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(.error(error.localizedDescription)))
                }
            }else{
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
        }
    }
}
