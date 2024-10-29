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
    func createAccount(email: String, password: String) async {
        // Auth.auth().createUser(withEmail: email, password: password)
        
//        Auth.auth().createUser(withEmail: email, password: password) { result, error in
//            print("Firebaseサーバからの結果が通知されました")
//            
//            if let error = error {
//                print("ユーザー登録失敗: \(error.localizedDescription)")
//            }
//            
//            if let result = result {
//                print("ユーザー登録成功: \(result.user.email)")
//            }
//        }
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("ユーザー登録成功: \(result.user.email)")
        } catch {
            // catchの中では、「error」という変数名でエラー内容を利用できる
            print("ユーザー登録失敗: \(error.localizedDescription)")
        }
        
        
        print("アカウント登録画面から呼び出されました")
    }
    
    // Delete Account
}
