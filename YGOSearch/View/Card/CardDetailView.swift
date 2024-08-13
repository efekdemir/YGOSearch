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
                Text(card.name)
                    .font(.title)
                Text(card.type)
                    .font(.subheadline)

                // Image gallery
                TabView(selection: $selectedImageIndex) {
                    ForEach(card.card_images.indices, id: \.self) { index in
                        if let imageUrl = URL(string: card.card_images[index].image_url) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
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
                .frame(height: 300)

                Text("Swipe to see alternate arts. Tap to view full size.")
                    .font(.footnote)
                
                CardTextView(text: card.desc)
                
                HStack {
                    if let atk = card.atk {
                        Text("ATK: \(atk)")
                            .bold()
                    }
                    if let def = card.def {
                        Text("DEF: \(def)")
                            .bold()
                    }
                }
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
