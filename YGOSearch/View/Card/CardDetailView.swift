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
                CardTitleView(card: card)
                
                CardImagesTabView(card: card, selectedImageIndex: $selectedImageIndex, shouldPresentImageSheet: $shouldPresentImageSheet)

                Text("Swipe to see alternate arts. Tap to view full size.")
                    .font(.footnote)
                
                CardSummaryView(type: card.type, frameType: card.frameType, race: card.race, atk: card.atk, def: card.def, level: card.level,
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
