//
//  MyPageRow.swift
//  MatchingSwift
//

import SwiftUI

struct MyPageRow: View {
    
    let iconName: String
    let label: String
    let tintColor: Color
    let value: String?
    
    var body: some View {
        
        HStack(spacing: 16) {
            Image(systemName: iconName)
                .imageScale(.large)
                .foregroundStyle(tintColor)
            
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.black)
            
            if let value = value {
                Spacer()
                
                Text(value)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        
    }
}

#Preview {
    MyPageRow(iconName: "person.fill", label: "label", tintColor: .red, value: "1.0.0")
}
