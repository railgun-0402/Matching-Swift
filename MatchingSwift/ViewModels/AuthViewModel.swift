//
//  AuthViewModel.swift
//  MatchingSwift
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    
    // Login
    
    // Logout
    
    // Create Account
    func createAccount(email: String, password: String) {
        // Auth.auth().createUser(withEmail: email, password: password)
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            print("Firebaseサーバからの結果が通知されました")
            
            if let error = error {
                print("ユーザー登録失敗: \(error.localizedDescription)")
            }
            
            if let result = result {
                print("ユーザー登録成功: \(result.user.email)")
            }
        }
        
        print("アカウント登録画面から呼び出されました")
    }
    
    // Delete Account
}
