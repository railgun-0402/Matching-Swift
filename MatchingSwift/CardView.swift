//
//  CardView.swift
//  MatchingSwift
//

import SwiftUI

struct CardView: View {
    
    // カードの起点位置
    private var offset: CGSize = .zero
    
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
    }
}

#Preview {
    ListView()
}

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
