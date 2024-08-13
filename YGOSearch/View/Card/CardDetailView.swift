//
//  CardView.swift
//  YGOSearch
//
//  Created by Efe Demir on 6/24/24.
//
import SwiftUI

struct CardDetailView: View {
    var card: CardModel

    @State private var shouldPresentImageSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text(card.name)
                    .font(.title)
                Text(card.type)
                    .font(.subheadline)
                if let imageUrl = URL(string: card.card_images.first?.image_url_cropped ?? "") {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                shouldPresentImageSheet = true
                            }
                    } placeholder: {
                        ProgressView()
                    }
                }
                Text("Tap image to see original card")
                    .font(.footnote)
                CardTextView(text: card.desc)
                
                HStack() {
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
            if let fullImageUrl = URL(string: card.card_images.first?.image_url ?? "") {
                AsyncImage(url: fullImageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.all)
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}