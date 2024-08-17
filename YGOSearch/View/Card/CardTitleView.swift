//
//  CardTitleView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/14/24.
//

import SwiftUI

struct CardTitleView: View {
    var card: CardModel
    
    var body: some View {
        HStack {
            let length = card.name.count
            if length > 35 {
                Text(card.name)
                    .font(.title)
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.3)
                    .padding(.horizontal)
            } else {
                Text(card.name)
                    .font(.title)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.3)
                    .padding(.horizontal)
            }
            if card.type != "Link Monster" {
                if let level = card.level {
                    ZStack {
                        Image(card.type.contains("XYZ") ? "rank" : "level")
                            .resizable()
                            .frame(width: 35, height: 35)
                        Text("\(level)")
                            .foregroundColor(.black)
                            .font(.system(size: 13))
                            .bold()
                        
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}
