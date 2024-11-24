//
//  ListViewModel.swift
//  MatchingSwift
//

import Foundation
import FirebaseFirestore

class ListViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    private var currentIndex = 0
    
    /* initializer */
    @MainActor
    init() {
        // self.users = getMockUsers()
        
        Task {
            self.users = await fetchUsers()            
        }
    }
    
    /* Mockユーザーを取得 */
    private func getMockUsers() -> [User] {
        return [
            User.MOCK_USER1,
            User.MOCK_USER2,
            User.MOCK_USER3,
            User.MOCK_USER4,
            User.MOCK_USER5,
            User.MOCK_USER6,
            User.MOCK_USER7,
        ]
    }
    
    
    /* Firebaseからユーザ情報取得 */
    private func fetchUsers() async -> [User] {
        do {
            let snapshot = try await Firestore.firestore().collection("users").getDocuments()
            var tempUsers = [User]()
            
            for document in snapshot.documents {
                let user = try document.data(as: User.self)
                tempUsers.append(user)
            }
            
            return tempUsers
        } catch {
            print("ユーザーデータ取得失敗：\(error.localizedDescription)")
            return []
        }
    }
    
    /* Redoボタンかどうか判断する */
    func adjustIndex(isRedo: Bool) {
        if isRedo {
            currentIndex -= 1
        } else {
            currentIndex += 1
        }
    }
    
    /* カード画面でボタンをタップ時処理 */
    func tappedHandler(action: Action) {
        switch action {         
            
        case .nope, .like:
            // 存在しない要素へのアクセスを防ぐ
            if currentIndex >= users.count { return }
        case .redo:
            if currentIndex <= 0 { return }
        }
        
        // 通知の送信
        NotificationCenter.default.post(name: Notification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": action == .redo ? users[currentIndex - 1].id : users[currentIndex].id,
            "action": action
        ])
    }
}
