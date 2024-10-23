//
//  BasicButton.swift
//  MatchingSwift
//

import SwiftUI

/* ボタンの共通レイアウト */
struct BasicButton: View {
    
    let label: String
    var icon: String? = nil
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(label)
                if let name = icon {
                    Image(systemName: name)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .background(Color.red)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    BasicButton(label: "ボタン") {
        print("ボタンがタップされました")
    }
}
