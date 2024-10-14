//
//  ListViewModel.swift
//  MatchingSwift
//

import Foundation

class ListViewModel {
    
    var users = [User]()
    
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
}
