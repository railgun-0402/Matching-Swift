//
//  ListView.swift
//  MatchingSwift
//

import SwiftUI

struct ListView: View {
    
    private let viewModel = ListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Cards
            cards
            
            // Actions(button)
            actions

        }
        .background(.black, in: RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 6) // 背景の下の角がくり抜かれる
    }
}

#Preview {
    ListView()
}

extension ListView {
    
    private var cards: some View {
        ZStack {
            ForEach(viewModel.users.reversed()) { user in
                CardView(user: user) { isRedo in
                    viewModel.adjustIndex(isRedo: isRedo)
                }
            }
        }
    }
    
    private var actions: some View {
        HStack(spacing: 68) {
            /* 罰ボタン */
            Button {
                viewModel.nopeButtonTapped()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(.red)
                    .background {
                        Circle()
                            .stroke(.red, lineWidth: 1)
                            .frame(width: 60, height: 60)
                    }
            }

            /* 矢印ボタン */
            Button {
                viewModel.redoButtonTapped()
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(.yellow)
                    .background {
                        Circle()
                            .stroke(.red, lineWidth: 1)
                            .frame(width: 50, height: 50)
                    }
            }
            
            /* いいねボタン */
            Button {
                viewModel.likeButtonTapped()
            } label: {
                Image(systemName: "heart")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(.mint)
                    .background {
                        Circle()
                            .stroke(.red, lineWidth: 1)
                            .frame(width: 60, height: 60)
                    }
            }

        }
        .foregroundStyle(.white)
        .frame(height: 100)
    }
}
