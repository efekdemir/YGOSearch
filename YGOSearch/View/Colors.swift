//
//  Colors.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/14/24.
//

import SwiftUICore
import SwiftUI

enum FrameType: String {
   case effectMonster = "effect"
   case normalMonster = "normal"
   case pendulum = "effect_pendulum"
   case spell = "spell"
   case ritualMonster = "ritual"
   case linkMonster = "link"
   case fusionMonster = "fusion"
   case trap = "trap"
   case synchroMonster = "synchro"
   case token = "token"
   case xyzMonster = "xyz"
}


let frameSummaryColors: [FrameType: Color] = [
    .effectMonster: Color(.orange),
    .normalMonster: Color(.systemYellow),
    .pendulum: Color(.systemCyan),
    .spell: Color(.green),
    .ritualMonster: Color(.systemMint),
    .linkMonster: Color(.systemIndigo),
    .fusionMonster: Color(.purple),
    .trap: Color(.red),
    .synchroMonster: Color(.white),
    .token: Color(.gray),
    .xyzMonster: Color(.black)
]
