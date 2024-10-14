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
    
    private var gesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let moveWidth = value.translation.width
                let moveHeight = value.translation.height
                
//                var limitedHeight: CGFloat = 0
//                
//                /*
//                 * 垂直方向では-100〜100の範囲で動かす
//                 */
//                if (moveHeight > 0) {
//                    if (moveHeight > 100) {
//                        limitedHeight = 100
//                    } else {
//                        limitedHeight = moveHeight
//                    }
//                } else {
//                    if (moveHeight < -100) {
//                        limitedHeight = -100
//                    } else {
//                        limitedHeight = moveHeight
//                    }
//                }

                /*
                 * 垂直方向では-100〜100の範囲で動かす
                 */
                let limitedHeight = moveHeight > 0 ? min(moveHeight, 100) : max(moveHeight, -100)
                
                
                offset = CGSize(width: moveWidth, height: limitedHeight)
                
            }
            .onEnded { value in
                withAnimation(.smooth) {
                    offset = .zero
                }
            }
    }
}
