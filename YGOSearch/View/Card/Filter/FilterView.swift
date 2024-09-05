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
    @Binding var selectedSpellTraps: Set<String>
    @Binding var attackValue: String
    @Binding var defenseValue: String
    @Binding var attackCondition: String
    @Binding var defenseCondition: String
    @Binding var selectedLevels: Set<Int>
    @Binding var selectedLinkRatings: Set<Int>
    
    let cardTypes: [String] = [
        "Effect Monster", "Flip Effect Monster", "Gemini Monster", "Normal Monster",
        "Ritual Monster", "Spell Card", "Trap Card", "Fusion Monster", "Link Monster",
        "Synchro Monster", "XYZ Monster", "Skill Card", "Token"
    ]
    
    let races: [String] = ["Aqua", "Beast", "Beast-Warrior", "Creator God", "Cyberse", "Dinosaur", "Divine-Beast", "Dragon", "Fairy", "Fiend", "Fish", "Insect", "Illusion", "Machine", "Plant", "Psychic", "Pyro", "Reptile", "Rock", "Sea Serpent", "Spellcaster", "Thunder", "Warrior", "Winged Beast", "Wyrm", "Zombie"]
    
    let spellTrapTypes: [String] = ["Normal Spell", "Continuous Spell", "Equip Spell", "Quick-Play Spell", "Field Spell", "Ritual Spell", "Normal Trap", "Continuous Trap", "Counter Trap"]
    
    var onApply: () -> Void
    var onClose: () -> Void
    
    
    var body: some View {
        VStack {
            Text("Card Filters")
                .bold()
                .font(.largeTitle)
                .frame(alignment: .top)
            
            CardSelectionView(selectedTypes: $selectedTypes, selectedRaces: $selectedRaces, selectedSpellTraps: $selectedSpellTraps, cardTypes: cardTypes, spellTrapTypes: spellTrapTypes, races: races)
            
            Divider()
                .padding()
            
            AttackDefenseInputView(attackValue: $attackValue, defenseValue: $defenseValue, attackCondition: $attackCondition, defenseCondition: $defenseCondition)
            
            Divider()
                .padding()
            
            LevelLinkSelectionView(selectedLevels: $selectedLevels, selectedLinkRatings: $selectedLinkRatings)
            
            Divider()
                .padding()
            
            ActionButtonsView(onApply: onApply, onClose: onClose)
        }
        .padding(.bottom)
    }
}
