//
//  CardView.swift
//  MatchingSwift
//

import SwiftUI

struct CardView: View {
    
    // カードの起点位置(ラッピング)
    @State private var offset: CGSize = .zero
    let user: User
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background
            Color.black
            
            // image
            imageLayer
            
            // Gradient
            LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom)
            
            // Information (プロフィール)
            informationLayer
            
            // LIKE and NOPE
            LikeAndNope
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .offset(offset)
        .gesture(gesture)
        .scaleEffect(scale)
        .rotationEffect(.degrees(angle))
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NOPEACTION"),
                                                        object: nil)) { data in
            print("ListViewModelからの通知を受信しました \(data)")
            
            guard
                let info = data.userInfo,
                let id = info["id"] as? String
            else { return }
            
            // 同じUserの際のみカードを外に出す
            if id == user.id {
                removeCard(isLiked: false)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("LIKEACTION"),
                                                        object: nil)) { data in
            print("ListViewModelからの通知を受信しました \(data)")
            
            guard
                let info = data.userInfo,
                let id = info["id"] as? String
            else { return }
            
            // 同じUserの際のみカードを外に出す
            if id == user.id {
                removeCard(isLiked: true)
            }
        }
    }
}

#Preview {
    ListView()
}

// MARK: -UI
extension CardView {
    
    private var imageLayer: some View {
        Image(user.photoUrl ?? "avatar")
            .resizable() // 画像の大きさ調整
            .aspectRatio(contentMode: .fill)
            .frame(width: 100) // 親要素のZ領域でくり抜きたい
    }
    
    private var informationLayer: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(user.name)
                    .font(.largeTitle.bold())
                
                Text("\(user.age)")
                    .font(.title2)
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.white, .blue)
                    .font(.title2)
                
            }
            // メッセージ設定がない人は表示させない
            if let message = user.message {
                Text(message)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .foregroundStyle(.white)
        
    }
    
    private var LikeAndNope: some View {
        HStack {
            // LIKE
            Text("LIKE")
                .tracking(4)
                .foregroundStyle(.green)
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.green, lineWidth: 5)
                )
                .rotationEffect(Angle(degrees: -15))
                .offset(x: 16, y: 30)
                .opacity(opacity)
            
            Spacer()
            
            // NOPE
            Text("NOPE")
                .tracking(4)
                .foregroundStyle(.red)
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.red, lineWidth: 5)
                )
                .rotationEffect(Angle(degrees: 15))
                .offset(x: -16, y: 36)
                .opacity(-opacity)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

// MARK: -Action
extension CardView {
    
    /* 移動量の制御 */
    private var screenWidth: CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as?
                UIWindowScene else { return 0.0 }
        // 画面幅を取得
        return window.screen.bounds.width
    }
    
    /* 移動割合の制御 */
    private var scale: CGFloat {
        // (水平方向の値/画面の横幅)
        // Max 0.75
        return max(1.0 - (abs(offset.width) / screenWidth), 0.75)
    }
    
    /* 傾きの制御 */
    private var angle: Double {
        // (水平方向の値/画面の横幅)だと最大1度なので10をかける
        return (offset.width / screenWidth) * 10.0
    }
    
    /* 透明度の制御 */
    private var opacity: Double {
        return (offset.width / screenWidth) * 4.0
    }
    
    /* カードを左の外に出す */
    private func removeCard(isLiked: Bool, height: CGFloat = 0.0) {
        withAnimation(.smooth) {
            offset = CGSize(width: isLiked ? screenWidth * 1.5 : -screenWidth * 1.5, height: height)
        }
    }
    
    private var gesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let moveWidth = value.translation.width
                let moveHeight = value.translation.height
                
                /*
                 * 垂直方向では-100〜100の範囲で動かす
                 */
                let limitedHeight = moveHeight > 0 ? min(moveHeight, 100) : max(moveHeight, -100)
                
                
                offset = CGSize(width: moveWidth, height: limitedHeight)
                
            }
            .onEnded { value in
                
                let width = value.translation.width
                let height = value.translation.height
                
                // 移動量が25%以上ある場合はカードを画面外へ
                if (abs(width) > (screenWidth / 4)) {
                    removeCard(isLiked: width > 0, height: height)
                } else {
                    withAnimation(.smooth) {
                        offset = .zero
                    }
                }
            }
    }
}
