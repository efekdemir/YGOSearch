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
            
            if let banlistInfo {
                BanlistSummaryView(banlistInfo: banlistInfo)
            }
        }
        .adjustableFontSize()
        .bold()
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .foregroundColor(frameType == "synchro" || frameType == "normal" ? .black : .white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(frameType == "xyz" ? Color.white : frameType == "synchro" ? Color.black : Color.clear, lineWidth: 4))
        .cornerRadius(10)
        .padding()
    }
}
