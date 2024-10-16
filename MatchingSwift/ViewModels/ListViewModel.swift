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
    
    /* Redoボタンかどうか判断する */
    func adjustIndex(isRedo: Bool) {
        if isRedo {
            currentIndex -= 1
        } else {
            currentIndex += 1
        }
    }
    
    /* ✖️ボタン押下時 */
    func nopeButtonTapped() {
        // 存在しない要素へのアクセスを防ぐ
        if currentIndex >= users.count { return }
        
        // 通知の送信
        NotificationCenter.default.post(name: Notification.Name("NOPEACTION"), object: nil, userInfo: [
            "id": users[currentIndex].id
        ])
    }
    
    /* LIKEボタン押下時 */
    func likeButtonTapped() {
        // 存在しない要素へのアクセスを防ぐ
        if currentIndex >= users.count { return }
        
        // 通知の送信
        NotificationCenter.default.post(name: Notification.Name("LIKEACTION"), object: nil, userInfo: [
            "id": users[currentIndex].id
        ])
    }
    
    /* redoボタン押下時 */
    func redoButtonTapped() {
        // 存在しない要素へのアクセスを防ぐ
        if currentIndex <= 0 { return }
        
        // 通知の送信
        NotificationCenter.default.post(name: Notification.Name("REDOACTION"), object: nil, userInfo: [
            "id": users[currentIndex - 1].id
        ])
    }
}
