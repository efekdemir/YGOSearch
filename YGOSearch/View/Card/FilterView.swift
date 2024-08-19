//
//  FilterView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/17/24.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedTypes: Set<String>
    let cardTypes: [String] = [
        "Effect Monster", "Flip Effect Monster", "Gemini Monster", "Normal Monster",
        "Ritual Monster", "Spell Card", "Trap Card", "Fusion Monster", "Link Monster",
        "Synchro Monster", "XYZ Monster", "Skill Card", "Token"
    ]
    
    var onApply: () -> Void
    var onClose: () -> Void

    var body: some View {
        VStack {
            Text("Filter by Type")
                .font(.headline)
                .bold()
                .padding()
            
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

            List(cardTypes, id: \.self) { type in
                Button(action: {
                    if selectedTypes.contains(type) {
                        selectedTypes.remove(type)
                    } else {
                        selectedTypes.insert(type)
                    }
                }) {
                    HStack {
                        Text(type)
                            .adjustableFontSize()
                        Spacer()
                        if selectedTypes.contains(type) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

