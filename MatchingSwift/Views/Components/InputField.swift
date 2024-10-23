//
//  InputField.swift
//  MatchingSwift
//

import SwiftUI

/* テキストの共通レイアウト */
struct InputField: View {
    
    // データバインディング
    @Binding var text: String
    let label: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(label)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecureField {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }            
            Divider()
        }
    }
}

#Preview {
    InputField(text: .constant(""), label: "メールアドレス", placeholder: "入力してください")
}
