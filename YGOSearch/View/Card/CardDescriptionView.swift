//
//  CardTextView.swift
//  YGOSearch
//
//  Created by Efe Demir on 7/4/24.
//

import SwiftUI

struct CardDescriptionView: View {
    var text: String

    var body: some View {
        Text(text)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
    }
}


#Preview {
    CardDescriptionView(text: "Blue-Eyes White Dragon")
}
