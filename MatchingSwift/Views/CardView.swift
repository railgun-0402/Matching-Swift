//
//  CardView.swift
//  MatchingSwift
//

import SwiftUI

struct CardView: View {
    
    // カードの起点位置(ラッピング)
    @State private var offset: CGSize = .zero
    let user: User
    let adjustIndex: (Bool) -> Void
    
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
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"),
                                                        object: nil)) { data in
            receiveHandler(data: data)
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
                .likeNopeText(isLike: true)
                .opacity(opacity)
            
            Spacer()
            
            // NOPE
            Text("NOPE")
                .likeNopeText(isLike: false)
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
        
        adjustIndex(false)
    }
    
    /* カードを1枚元に戻す */
    private func resetCard() {
        withAnimation(.smooth) {
            offset = .zero
        }
        adjustIndex(true)
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
                    resetCard()
                }
            }
    }
    
    /* ボタン押下時の処理 */
    private func receiveHandler(data: NotificationCenter.Publisher.Output) {
        guard
            let info = data.userInfo,
            let id = info["id"] as? String,
            let action = info["action"] as? Action
        else { return }
        
        // 同じUserの際のみカードを外に出す
        if id == user.id {
            switch action {
            // いいねとNoはカードを除外
            case .nope:
                removeCard(isLiked: false)
            case .redo:
                resetCard()
            case .like:
                removeCard(isLiked: true)
            }
            
        }
    }
}
