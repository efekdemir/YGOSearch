//
//  ErrorBanner.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/16/24.
//

import SwiftUI

struct ErrorBanner: View {
    @Binding var errorMessage: String?
    @Binding var showError: Bool

    var body: some View {
        if showError, let message = errorMessage {
            Text(message)
                .foregroundColor(.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(8)
                .transition(.slide)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            self.showError = false
                        }
                    }
                }
        }
    }
}

#Preview {
    ErrorBanner(errorMessage: .constant("Error!"), showError: .constant(true))
}
