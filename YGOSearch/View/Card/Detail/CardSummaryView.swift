//
//  CardSummaryView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/13/24.
//

import SwiftUI

struct CardSummaryView: View {
    var type: String
    var frameType: String
    var race: String
    var atk: Int?
    var def: Int?
    var level: Int?
    var linkval: Int?
    var archetype: String?
    var attribute: String?
    var banlistInfo: CardModel.BanlistInfo?
    
    private var backgroundColor: Color {
        guard let frameType = FrameType(rawValue: frameType) else {
            return Color.gray
        }
        return frameSummaryColors[frameType] ?? Color.gray
    }
    
    var body: some View {
        VStack {
            if let banlistInfo {
                if let tcg = banlistInfo.ban_tcg {
                    Text(tcg)
                }
            }
            
            HStack {
                Text(type)
                Text("|")
                Text(race)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.3)
            .scaledToFit()
            
            HStack {
                if let attribute {
                    Text(attribute)
                }
                if let atk {
                    if atk == -1 {
                        Text("|  ATK: ?")
                    } else {
                        Text("|  ATK: \(atk)")
                    }
                    
                }
                if let def {
                    if def == -1 {
                        Text("|  DEF: ?")
                    } else {
                        Text("|  DEF: \(def)")
                    }
                    
                }
                if let linkval {
                    Text("|  LINK - \(linkval)")
                }
            }
            .lineLimit(1)
            .minimumScaleFactor(0.3)
        }
        .adjustableFontSize()
        .bold()
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .foregroundColor(frameType == "synchro" || frameType == "normal" ? .black : .white)
        .overlay(frameType == "synchro" ?
                 RoundedRectangle(cornerRadius: 10)
            .stroke(.black, lineWidth: 4) :
                    RoundedRectangle(cornerRadius: 10)
            .stroke(.clear)
        )
        .cornerRadius(10)
        .padding()
    }
}
