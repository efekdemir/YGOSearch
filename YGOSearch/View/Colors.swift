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
    .normalMonster: Color(.yellow),
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

//let frameSummaryColors: [FrameType: Color] = [
//    .effectMonster: Color(hex: "EACEC1"),
//    .normalMonster: Color(hex: "ECDFC4"),
//    .pendulum: Color(hex: "BBE2DB"),
//    .spell: Color(hex: "BBE2DB"),
//    .ritualMonster: Color(hex: "C9D4E8"),
//    .linkMonster: Color(hex: "CFD9EE"),
//    .fusionMonster: Color(hex: "DDC6E2"),
//    .trap: Color(hex: "E4BCD4"),
//    .synchroMonster: Color(hex: "F5F4F2"),
//    .token: Color(hex: "DEDDDE"),
//    .xyzMonster: Color(hex: "BCBCBC")
//]
//
//let frameTitleColors: [FrameType: Color] = [
//    .effectMonster: Color(hex: "B8622E"),
//    .normalMonster: Color(hex: "C09249"),
//    .pendulum: Color(hex: "B8622E"),
//    .spell: Color(hex: "1F9C90"),
//    .ritualMonster: Color(hex: "4A73B5"),
//    .linkMonster: Color(hex: "4588BC"),
//    .fusionMonster: Color(hex: "873796"),
//    .trap: Color(hex: "AC1973"),
//    .synchroMonster: Color(hex: "EEEDEB"),
//    .token: Color(hex: "7E7475"),
//    .xyzMonster: Color(hex: "2A2E31")
//]

//extension Color {
//    init(hex: String) {
//        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int: UInt64 = 0
//        Scanner(string: hex).scanHexInt64(&int)
//        let a, r, g, b: UInt64
//        switch hex.count {
//        case 3:
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6:
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8:
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (255, 0, 0, 0)
//        }
//
//        self.init(
//            .sRGB,
//            red: Double(r) / 255,
//            green: Double(g) / 255,
//            blue: Double(b) / 255,
//            opacity: Double(a) / 255
//        )
//    }
//}
