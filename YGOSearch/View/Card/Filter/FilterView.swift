//
//  FilterView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/17/24.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedTypes: Set<String>
    @Binding var selectedRaces: Set<String>
    @Binding var attackValue: String
    @Binding var defenseValue: String
    @Binding var attackCondition: String
    @Binding var defenseCondition: String
    @Binding var selectedLevels: Set<Int>
    @Binding var selectedLinkRatings: Set<Int>
    
    @State private var showingTypeSheet = false
    @State private var showingRaceSheet = false
    
    
    let cardTypes: [String] = [
        "Effect Monster", "Flip Effect Monster", "Gemini Monster", "Normal Monster",
        "Ritual Monster", "Spell Card", "Trap Card", "Fusion Monster", "Link Monster",
        "Synchro Monster", "XYZ Monster", "Skill Card", "Token"
    ]
    
    let races: [String] = ["Aqua", "Beast", "Beast-Warrior", "Creator God", "Cyberse", "Dinosaur", "Divine-Beast", "Dragon", "Fairy", "Fiend", "Fish", "Insect", "Illusion", "Machine", "Plant", "Psychic", "Pyro", "Reptile", "Rock", "Sea Serpent", "Spellcaster", "Thunder", "Warrior", "Winged Beast", "Wyrm", "Zombie"]
    
    var onApply: () -> Void
    var onClose: () -> Void
    
    
    var body: some View {
        VStack {
            Text("Card Filters")
                .bold()
                .font(.largeTitle)
                .frame(alignment: .top)
                        
            Text("Monster Race & Card Type")
                .font(.headline)
                .bold()
                .padding()
            
            HStack {
                Button("Select Races") {
                    showingRaceSheet = true
                }
                .padding(.bottom)
                .padding(.trailing)
                .sheet(isPresented: $showingRaceSheet) {
                    SelectionSheet(selectedItems: $selectedRaces, items: races, title: "Races")
                }
                Button("Select Types") {
                    showingTypeSheet = true
                }
                .padding(.bottom)
                .padding(.leading)
                .sheet(isPresented: $showingTypeSheet) {
                    SelectionSheet(selectedItems: $selectedTypes, items: cardTypes, title: "Card Types")
                }
            }
                        
            Text("Monster Attack & Defense")
                .bold()
            VStack {
                HStack {
                    TextField("ATK", text: $attackValue)
                        .keyboardType(.numberPad)
                        .padding(.leading)
                    Picker("Condition", selection: $attackCondition) {
                        Text("<").tag("<")
                        Text("=").tag("=")
                        Text(">").tag(">")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                
                HStack {
                    TextField("DEF", text: $defenseValue)
                        .keyboardType(.numberPad)
                        .padding(.leading)
                    Picker("Condition", selection: $defenseCondition) {
                        Text("<").tag("<")
                        Text("=").tag("=")
                        Text(">").tag(">")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
            }
            
            Divider()
            
            Text("Monster Level & Link Rating")
                .bold()
            
            VStack(alignment: .leading) {
                Text("Select Levels")
                    .font(.subheadline)
                HStack {
                    ForEach(1...12, id: \.self) { number in
                        NumberSelectButton(number: number, selectedNumbers: $selectedLevels)
                    }
                }
                
                Text("Select Link Ratings")
                    .font(.subheadline)
                HStack {
                    ForEach(1...6, id: \.self) { number in
                        NumberSelectButton(number: number, selectedNumbers: $selectedLinkRatings)
                    }
                }
            }
            
            Divider()
        }
        .padding(.bottom)
                
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

