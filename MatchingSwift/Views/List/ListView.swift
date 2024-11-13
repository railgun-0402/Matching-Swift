//
//  ListView.swift
//  MatchingSwift
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject private var viewModel = ListViewModel()
    
    var body: some View {
        Group {
            if viewModel.users.count > 0 {
                VStack(spacing: 0) {
                    // Cards
                    cards
                    
                    // Actions(button)
                    actions

                }
                .background(.black, in: RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal, 6) // 背景の下の角がくり抜かれる
            } else {
                ProgressView()
                    .padding()
                    .tint(Color.white)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .scaleEffect(1.5)
            }
        }
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
            
            ForEach (Action.allCases, id: \.self) { type in
                type.createActionButton(viewModel: viewModel)
            }                        
        }
        .foregroundStyle(.white)
        .frame(height: 100)
    }
}
