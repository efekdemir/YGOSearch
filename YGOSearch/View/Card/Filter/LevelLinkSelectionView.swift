//
//  LevelLinkSelectionView.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/4/24.
//

import SwiftUI

struct LevelLinkSelectionView: View {
    @Binding var selectedLevels: Set<Int>
    @Binding var selectedLinkRatings: Set<Int>

    var body: some View {
        VStack(alignment: .leading) {
            Text("Select Levels")
                .font(.headline)
            HStack {
                ForEach(1...12, id: \.self) { number in
                    NumberSelectButton(number: number, selectedNumbers: $selectedLevels)
                }
            }
            .padding(.bottom)
            
            Text("Select Link Ratings")
                .font(.headline)
            HStack {
                ForEach(1...6, id: \.self) { number in
                    NumberSelectButton(number: number, selectedNumbers: $selectedLinkRatings)
                }
            }
        }
    }
}
