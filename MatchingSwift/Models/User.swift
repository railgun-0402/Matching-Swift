//
//  User.swift
//  MatchingSwift
//

import Foundation

struct User: Identifiable {
    let id: String
    let name: String
    let email: String
    let age: Int
    var photoUrl: String?
    var message: String?
}

extension User {
    static let MOCK_USER1 = User(id: "1", name: "ブルー", email: "test1@example.com", age: 30, photoUrl: "user01", message: "ドライブが趣味です！色々なところに出掛けるのが好きです！")
    static let MOCK_USER2 = User(id: "2", name: "パープル", email: "test2@example.com", age: 28, photoUrl: "user02", message: "インドア派で外に出るのが苦手です。よろしくお願いします！")
    static let MOCK_USER3 = User(id: "3", name: "ピンク", email: "test3@example.com", age: 37, photoUrl: "user03", message: "自分で起業を目指しているので、そんなお話も出来たら良いなと思います")
    static let MOCK_USER4 = User(id: "4", name: "グリーン", email: "test4@example.com", age: 25, photoUrl: "user04", message: "楽しい時間を共有できる新しい友達を探しています！よろしくお願いします！")
    static let MOCK_USER5 = User(id: "5", name: "イエロー", email: "test5@example.com", age: 34, photoUrl: "user05")
    static let MOCK_USER6 = User(id: "6", name: "オレンジ", email: "test6@example.com", age: 24, message: "音楽や映画、読書も大好きで、新しいアーティストや作品を見つけるのが楽しみです")
    static let MOCK_USER7 = User(id: "7", name: "レッド", email: "test7@example.com", age: 36)
}
