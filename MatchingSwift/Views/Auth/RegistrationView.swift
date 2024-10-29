//
//  RegistrationView.swift
//  MatchingSwift
//

import SwiftUI

struct RegistrationView: View {
    
    private let authViewModel = AuthViewModel()
    
    @State private var email = ""
    @State private var age = 18
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    /* dismissでプロパティにハンドラ機能を与える */
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            // Image
            BrandImage()
            
            // Form
            VStack(spacing: 24) {
                /* メールアドレス */
                InputField(text: $email, label: "メールアドレス", placeholder: "入力してください")
                /* 氏名 */
                InputField(text: $username, label: "お名前", placeholder: "入力してください")                
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("年齢")
                            .foregroundColor(Color(.darkGray))
                            .fontWeight(.semibold)
                            .font(.footnote)
                        
                        Spacer()
                        
                        Picker(selection: $age) {
                            ForEach(18..<100) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        } label: {
                            Text("年齢")
                        }
                        .tint(.black)


                    }
                    
                    Divider()
                }
                
                /* パスワード */
                InputField(text: $password, label: "パスワード", placeholder: "半角英数字6文字以上", isSecureField: true)
                /* パスワード(確認用) */
                InputField(text: $confirmPassword, label: "パスワード(確認用)", placeholder: "もう一度、入力してください。", isSecureField: true)
            }
            
            /* ユーザ登録 */
            BasicButton(label: "登録", icon: "arrow.right") {
                // Taskで非同期処理の完了を待つ
                Task {
                    await authViewModel.createAccount(email: email, password: password)
                }
            }
            .padding(.top, 24)
            
            Spacer()
            
            // Navigation
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("すでにアカウントをお持ちの方")
                    Text("ログイン")
                        .fontWeight(.bold)
                }
                .foregroundColor(Color(.darkGray))
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    RegistrationView()
}
