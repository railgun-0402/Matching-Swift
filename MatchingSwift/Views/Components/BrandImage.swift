//
//  BrandImage.swift
//  MatchingSwift
//

import SwiftUI

/* Imageの共通レイアウト */
struct BrandImage: View {
    var body: some View {
        Image(systemName: "flame.circle.fill")
            .resizable()
            .scaledToFill()
            .foregroundStyle(.red)
            .frame(width: 120, height: 120)
            .padding(.vertical, 32)
    }
}

#Preview {
    BrandImage()
}
