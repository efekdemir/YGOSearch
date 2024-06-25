//
//  CardView.swift
//  YGOSearch
//
//  Created by Efe Demir on 6/24/24.
//
import SwiftUI

struct CardView: View {
    var card: CardModel

    @State private var shouldPresentSheet = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(card.name)
                    .font(.title)
                Text(card.type)
                    .font(.subheadline)
                if let imageUrl = URL(string: card.card_images.first?.image_url_cropped ?? "") {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 300)
                            .onTapGesture {
                                shouldPresentSheet = true
                            }
                    } placeholder: {
                        ProgressView()
                    }
                }
                Text("Tap image to see original card")
                    .font(.footnote)
                HStack {
                    Text("ATK: \(card.atk ?? 0)")
                        .bold()
                    Text("DEF: \(card.def ?? 0)")
                        .bold()
                }
                Text(card.desc)
                    .padding()
            }
        }
        .sheet(isPresented: $shouldPresentSheet) {  // Attach the sheet modifier here
            // Sheet content
            if let fullImageUrl = URL(string: card.card_images.first?.image_url ?? "") {
                AsyncImage(url: fullImageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.all)  // Optional: Allow the image to fill the entire screen area
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}
