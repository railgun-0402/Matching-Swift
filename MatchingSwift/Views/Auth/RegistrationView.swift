//
//  RegistrationView.swift
//  MatchingSwift
//

import SwiftUI

struct RegistrationView: View {
    
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
            Image(systemName: "flame.circle.fill")
                .resizable()
                .scaledToFill()
                .foregroundStyle(.red)
                .frame(width: 120, height: 120)
                .padding(.vertical, 32)
            
            // Form
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("メールアドレス")
                        .foregroundColor(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)
                    TextField("入力してください", text: $email)
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("お名前")
                        .foregroundColor(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)
                    TextField("入力してください", text: $username)
                    Divider()
                }
                
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
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("パスワード")
                        .foregroundColor(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)
                    SecureField("半角英数字6文字以上", text: $password)
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("パスワード(確認用)")
                        .foregroundColor(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)
                    SecureField("もう一度、入力してください。", text: $confirmPassword)
                    Divider()
                }
            }
            
            // Button
            Button {
                print("ログインボタンがタップされました。")
            } label: {
                HStack {
                    Text("登録")
                    Image(systemName: "arrow.right")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .background(Color.red)
                .clipShape(Capsule())
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
