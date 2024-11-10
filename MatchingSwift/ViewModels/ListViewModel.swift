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
