//
//  BanlistSummaryView.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/23/24.
//

import SwiftUI

struct BanlistSummaryView: View {
    var banlistInfo: CardModel.BanlistInfo
    
    var body: some View {
        HStack {
            if let tcg = banlistInfo.ban_tcg, let ocg = banlistInfo.ban_ocg, let goat = banlistInfo.ban_goat {
                switch (tcg, ocg, goat) {
                case (tcg, ocg, goat) where tcg == ocg && tcg == goat:
                    Text("TCG/OCG/GOAT: \(tcg)")
                    
                case (tcg, ocg, goat) where tcg == ocg:
                    Text("TCG/OCG: \(tcg), GOAT: \(goat)")
                    
                case (tcg, ocg, goat) where tcg == goat:
                    Text("TCG/GOAT: \(tcg), OCG: \(ocg)")
                    
                case (tcg, ocg, goat) where ocg == goat:
                    Text("OCG/GOAT: \(ocg), TCG: \(tcg)")
                    
                default:
                    Text("TCG: \(tcg), OCG: \(ocg), GOAT: \(goat)")
                }
            } else {
                switch (banlistInfo.ban_tcg, banlistInfo.ban_ocg, banlistInfo.ban_goat) {
                case (let tcg?, let ocg?, nil) where tcg == ocg:
                    Text("TCG/OCG: \(tcg)")
                    
                case (let tcg?, let ocg?, nil):
                    Text("TCG: \(tcg), OCG: \(ocg)")
                    
                case (let tcg?, nil, let goat?) where tcg == goat:
                    Text("TCG/GOAT: \(tcg)")
                    
                case (let tcg?, nil, let goat?):
                    Text("TCG: \(tcg), GOAT: \(goat)")
                    
                case (nil, let ocg?, let goat?) where ocg == goat:
                    Text("OCG/GOAT: \(ocg)")
                    
                case (nil, let ocg?, let goat?):
                    Text("OCG: \(ocg), GOAT: \(goat)")
                    
                case (let tcg?, nil, nil):
                    Text("TCG: \(tcg)")
                    
                case (nil, let ocg?, nil):
                    Text("OCG: \(ocg)")
                    
                case (nil, nil, let goat?):
                    Text("GOAT: \(goat)")
                    
                default:
                    Text("Unlimited")
                }
            }
        }
        .lineLimit(1)
    }
}
