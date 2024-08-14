//
//  CardSummaryView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/13/24.
//

import SwiftUI

struct CardSummaryView: View {
    var type: String
    var race: String
    var atk: Int?
    var def: Int?
    var level: Int?
    var linkval: Int?
    var archetype: String?
    var attribute: String?
    
    var body: some View {
        
            VStack {
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
                        Text("|  ATK: \(atk)")
                    }
                    if let def {
                        Text("|  DEF: \(def)")
                    }
                    if let linkval {
                        Text("|  LINK - \(linkval)")
                    }
                }
                
                if let level {
                    ZStack {
                        Image(type.contains("XYZ") ? "rank" : "level")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("\(level)")
                            .foregroundColor(.black)
                        
                    }
                }
            }
            .bold()
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
            
        }
}
