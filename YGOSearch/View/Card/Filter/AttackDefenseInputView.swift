//
//  AttackDefenseInputView.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/4/24.
//

import SwiftUI

struct AttackDefenseInputView: View {
    @Binding var attackValue: String
    @Binding var defenseValue: String
    @Binding var attackCondition: String
    @Binding var defenseCondition: String

    var body: some View {
        VStack {
            Text("Monster Attack & Defense")
                .bold()
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
    }
}
