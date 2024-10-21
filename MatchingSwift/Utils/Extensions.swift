//
//  Extensions.swift
//  MatchingSwift
//

import SwiftUI

extension Text {
    
    func likeNopeText(isLike: Bool) -> some View {
        self
            .tracking(4)
            .foregroundStyle(isLike ? .green : .red)
            .font(.system(size: 50))
            .fontWeight(.heavy)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isLike ? .green : .red, lineWidth: 5)
            )
            .rotationEffect(Angle(degrees: isLike ? -15 : 15))
            .offset(x: isLike ? 16 : -16, y: isLike ? 30 : 36)
    }
}
