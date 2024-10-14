//
//  CardView.swift
//  MatchingSwift
//

import SwiftUI

struct CardView: View {
    
    // カードの起点位置(ラッピング)
    @State private var offset: CGSize = .zero
    
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
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .offset(offset)
        .gesture(gesture)
        .scaleEffect(scale)
        .rotationEffect(.degrees(angle))
    }
}

#Preview {
    ListView()
}

// MARK: -UI
extension CardView {
    
    private var imageLayer: some View {
        Image("user01")
            .resizable() // 画像の大きさ調整
            .aspectRatio(contentMode: .fill)
            .frame(width: 100) // 親要素のZ領域でくり抜きたい
    }
    
    private var informationLayer: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text("ブルー")
                    .font(.largeTitle.bold())
                
                Text("99")
                    .font(.title2)
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.white, .blue)
                    .font(.title2)
                
            }
            Text("よろしくお願いします")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .foregroundStyle(.white)
        
    }
}

// MARK: -Action
extension CardView {
    
    private var screenWidth: CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as?
                UIWindowScene else { return 0.0 }
        // 画面幅を取得
        return window.screen.bounds.width
    }
    
    private var scale: CGFloat {
        // (水平方向の値/画面の横幅)
        // Max 0.75
        return max(1.0 - (abs(offset.width) / screenWidth), 0.75)
    }
    
    private var angle: Double {
        // (水平方向の値/画面の横幅)だと最大1度なので10をかける
        return (offset.width / screenWidth) * 10.0
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
                    withAnimation(.smooth) {
                        offset = CGSize(width: width > 0 ? screenWidth * 1.5 : -screenWidth * 1.5, height: height)
                    }
                } else {
                    withAnimation(.smooth) {
                        offset = .zero
                    }
                }
            }
    }
}
