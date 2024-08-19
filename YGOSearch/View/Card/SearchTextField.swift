//
//  SearchTextField.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/16/24.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var text: String
    var onCommit: () -> Void
    var onFilter: () -> Void

    var body: some View {
        HStack {
            TextField("🔍 Search card", text: $text, onCommit: onCommit)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
            }

            Button(action: onFilter) {
                Image(systemName: "slider.horizontal.3")
            }
        }
        .padding()
    }
}
