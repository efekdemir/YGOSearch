//
//  CardTitleView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/14/24.
//

import SwiftUI

struct CardTitleView: View {
    var card: CardModel
    
//    private var frameTitleColor: Color {
//        guard let frameType = FrameType(rawValue: card.frameType) else {
//            return Color.black
//        }
//        return frameTitleColors[frameType] ?? Color.black
//    }
    
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
//        .background(frameTitleColor)
    }
}


//                ZStack(alignment: .topTrailing) {
//                    TabView(selection: $selectedImageIndex) {
//                        ForEach(card.card_images.indices, id: \.self) { index in
//                            if let imageUrl = URL(string: card.card_images[index].image_url_cropped) {
//                                AsyncImage(url: imageUrl) { image in
//                                    image
//                                        .resizable()
//                                        .scaledToFill()
//                                        .clipped()
//                                        .onTapGesture {
//                                            shouldPresentImageSheet = true
//                                        }
//                                        .tag(index)
//                                } placeholder: {
//                                    ProgressView()
//                                }
//                            }
//                        }
//                    }
//                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
//
//                    if let level = card.level {
//                        ZStack {
//                            Image(card.type.contains("XYZ") ? "rank" : "level")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                                .padding([.top, .trailing], 10)
//
//                            Text("\(level)")
//                                .foregroundColor(.black)
//                                .padding([.top, .trailing], 10)
//                                .bold()
//                        }
//                    }
//                }
//                .frame(height: card.type.contains("Pendulum Effect Monster") ? 500 : 400)
