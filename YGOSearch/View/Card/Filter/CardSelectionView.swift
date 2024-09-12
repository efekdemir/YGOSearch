//
//  TypeAndRaceSelectionView.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/4/24.
//

import SwiftUI

struct CardSelectionView: View {
    @Binding var selectedAttributes: Set<String>
    @Binding var selectedTypes: Set<String>
    @Binding var selectedRaces: Set<String>
    @Binding var selectedSpellTraps: Set<String>
    let attributes: [String]
    let cardTypes: [String]
    let spellTrapTypes: [String]
    let races: [String]
    @State private var showingAttributeSheet = false
    @State private var showingTypeSheet = false
    @State private var showingRaceSheet = false
    @State private var showingSpellTrapSheet = false

    var body: some View {
        VStack {
            Text("Filter by")
                .font(.headline)
                .bold()
                .padding()
            
            VStack {
                HStack {
                    Button(action: {
                        showingTypeSheet = true
                    }) {
                        HStack {
                            Text("Card Types")
                            if !selectedTypes.isEmpty {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding(.bottom)
                    .padding(.horizontal)
                    .sheet(isPresented: $showingTypeSheet) {
                        SelectionSheet(selectedItems: $selectedTypes, items: cardTypes, title: "Card Types")
                    }
                    
                    Button(action: {
                        showingSpellTrapSheet = true
                    }) {
                        HStack {
                            Text("Spells & Traps")
                            if !selectedSpellTraps.isEmpty {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding(.bottom)
                    .padding(.trailing)
                    .sheet(isPresented: $showingSpellTrapSheet) {
                        SelectionSheet(selectedItems: $selectedSpellTraps, items: spellTrapTypes, title: "Spells & Traps")
                    }
                }
                
                HStack {
                    Button(action: {
                        showingAttributeSheet = true
                    }) {
                        HStack {
                            Text("Monster Attributes")
                            if !selectedAttributes.isEmpty {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding(.bottom)
                    .padding(.leading)
                    .sheet(isPresented: $showingAttributeSheet) {
                        SelectionSheet(selectedItems: $selectedAttributes, items: attributes, title: "Monster Attributes")
                    }
                    
                    Button(action: {
                        showingRaceSheet = true
                    }) {
                        HStack {
                            Text("Monster Races")
                            if !selectedRaces.isEmpty {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding(.bottom)
                    .padding(.leading)
                    .sheet(isPresented: $showingRaceSheet) {
                        SelectionSheet(selectedItems: $selectedRaces, items: races, title: "Monster Races")
                    }
                }
            }
        }
    }
}
