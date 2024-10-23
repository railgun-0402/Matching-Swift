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
            
            ForEach (Action.allCases, id: \.self) { type in
                type.createActionButton(viewModel: viewModel)
            }                        
        }
        .foregroundStyle(.white)
        .frame(height: 100)
    }
}
