//
//  CardView.swift
//  YGOSearch
//
//  Created by Efe Demir on 6/24/24.
//
import SwiftUI

struct CardDetailView: View {
    var card: CardModel
    @State private var selectedImageIndex = 0
    @State private var shouldPresentImageSheet = false
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
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

                TabView(selection: $selectedImageIndex) {
                    ForEach(card.card_images.indices, id: \.self) { index in
                        if let imageUrl = URL(string: card.card_images[index].image_url_cropped) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .onTapGesture {
                                        shouldPresentImageSheet = true
                                    }
                                    .tag(index)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: card.type.contains("Pendulum Effect Monster") ? 500 : 400)

                Text("Swipe to see alternate arts. Tap to view full size.")
                    .font(.footnote)
                
                CardSummaryView(type: card.type, race: card.race, atk: card.atk, def: card.def, level: card.level,
                                linkval: card.linkval, archetype: card.archetype, attribute: card.attribute)
                
                CardDescriptionView(text: card.desc)
                
            }
        }
        .sheet(isPresented: $shouldPresentImageSheet) {
            if let fullImageUrl = URL(string: card.card_images[selectedImageIndex].image_url) {
                FullImageSheet(imageUrl: fullImageUrl)
            }
        }
    }

    @ViewBuilder
    func FullImageSheet(imageUrl: URL) -> some View {
        AsyncImage(url: imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
        } placeholder: {
            ProgressView()
        }
    }
}
