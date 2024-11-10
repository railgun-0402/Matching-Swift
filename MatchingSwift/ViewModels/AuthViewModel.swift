//
//  AuthViewModel.swift
//  MatchingSwift
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    // userSessionが変更すると、通知を送る
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("ログインユーザー：\(self.userSession?.email)")
        // Test for logout
         logout()
    }
    
    // Login
     @MainActor
    func login(email: String, password: String) async {
        do {
            let result =  try await Auth.auth().signIn(withEmail: email, password: password)
            print("ログイン成功： \(result.user.email)")
            self.userSession = result.user
            print("self.userSession:\(self.userSession?.email)")
            
        } catch {
            print("ログイン失敗： \(error.localizedDescription)")
        }
        
    }
    
    // Logout
    func logout() {
        do {
            try Auth.auth().signOut()
            print("ログアウト成功")
            self.userSession = nil
        } catch {
            print("ログアウト失敗：\(error.localizedDescription)")
        }
    }
    
    // Create Account
    func createAccount(email: String, password: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("ユーザー登録成功: \(result.user.email)")
            self.userSession = result.user
        } catch {
            // catchの中では、「error」という変数名でエラー内容を利用できる
            print("ユーザー登録失敗: \(error.localizedDescription)")
        }
        
        
        print("アカウント登録画面から呼び出されました")
    }
    
    // Delete Account
}
