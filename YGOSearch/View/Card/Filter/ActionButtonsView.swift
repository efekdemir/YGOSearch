//
//  ActionButtonsView.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/4/24.
//

import SwiftUI

struct ActionButtonsView: View {
    var onApply: () -> Void
    var onClose: () -> Void

    var body: some View {
        HStack {
            Button("Reset") {
                onClose()
            }
            .adjustableFontSize()
            .padding()
            .bold()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(10)
            
            Button("Apply") {
                onApply()
            }
            .adjustableFontSize()
            .padding()
            .bold()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
        }
    }
}
