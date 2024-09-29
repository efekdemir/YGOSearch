//
//  EmptyView.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/23/24.
//

import SwiftUI

struct EmptyCardsView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("No cards found!")
                .font(.title2)
                .padding(.bottom, 10)
            
            Text("Try searching with different keywords or adjust the filters.")
                .font(.body)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}
