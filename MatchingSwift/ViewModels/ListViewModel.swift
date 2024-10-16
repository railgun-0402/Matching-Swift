//
//  ListViewModel.swift
//  MatchingSwift
//

import Foundation

class ListViewModel {
    
    var users = [User]()
    
    private var currentIndex = 0
    
    /* initializer */
    init() {
        self.users = getMockUsers()
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
    
    /* ✖️ボタン押下時 */
    func nopeButtonTapped() {
        // 存在しない要素へのアクセスを防ぐ
        if currentIndex >= users.count { return }
        
        // 通知の送信
        NotificationCenter.default.post(name: Notification.Name("NOPEACTION"), object: nil, userInfo: [
            "id": users[currentIndex].id
        ])
        
        currentIndex += 1
    }
    
    
    /* LIKEボタン押下時 */
    func likeButtonTapped() {
        // 存在しない要素へのアクセスを防ぐ
        if currentIndex >= users.count { return }
        
        // 通知の送信
        NotificationCenter.default.post(name: Notification.Name("LIKEACTION"), object: nil, userInfo: [
            "id": users[currentIndex].id
        ])
        
        currentIndex += 1
    }

}
