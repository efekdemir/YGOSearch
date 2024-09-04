//
//  TypeAndRaceSelectionView.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/4/24.
//

import SwiftUI

struct TypeRaceSelectionView: View {
    @Binding var selectedTypes: Set<String>
    @Binding var selectedRaces: Set<String>
    let cardTypes: [String]
    let races: [String]
    @State private var showingTypeSheet = false
    @State private var showingRaceSheet = false

    var body: some View {
        VStack {
            Text("Monster Race & Card Type")
                .font(.headline)
                .bold()
                .padding()
            
            HStack {
                Button(action: {
                    showingRaceSheet = true
                }) {
                    HStack {
                        Text("Select Races")
                        if !selectedRaces.isEmpty {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
                .padding(.bottom)
                .padding(.trailing)
                .sheet(isPresented: $showingRaceSheet) {
                    SelectionSheet(selectedItems: $selectedRaces, items: races, title: "Races")
                }

                Button(action: {
                    showingTypeSheet = true
                }) {
                    HStack {
                        Text("Select Types")
                        if !selectedTypes.isEmpty {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
                .padding(.bottom)
                .padding(.leading)
                .sheet(isPresented: $showingTypeSheet) {
                    SelectionSheet(selectedItems: $selectedTypes, items: cardTypes, title: "Card Types")
                }
            }
        }
    }
}
