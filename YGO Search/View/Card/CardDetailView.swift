//
//  CardView.swift
//  YGO Search
//
//  Created by Efe Demir on 6/24/24.
//
import SwiftUI

struct CardDetailView: View {
    var card: CardModel
    @State private var shouldPresentSheet = false
    @State private var showingDeckSelection = false  // State to control deck selection view presentation

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text(card.name)
                    .font(.title)
                Text(card.type)
                    .font(.subheadline)
                AsyncImageCard(imageUrl: card.card_images.first?.image_url_cropped)
                Text("Tap image to see original card")
                    .font(.footnote)
                CardTextView(text: card.desc)
                HStack {
                    if let atk = card.atk {
                        Text("ATK: \(atk)").bold()
                    }
                    if let def = card.def {
                        Text("DEF: \(def)").bold()
                    }
                }
                Button("Add Card to Deck") {
                    showingDeckSelection = true
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .sheet(isPresented: $shouldPresentSheet) {
            FullImageSheet(imageUrl: card.card_images.first?.image_url)
        }
        .sheet(isPresented: $showingDeckSelection) {
            DeckSelectionView(selectedCard: card)
        }
    }

    @ViewBuilder
    func AsyncImageCard(imageUrl: String?) -> some View {
        if let imageUrl = URL(string: imageUrl ?? "") {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(maxWidth: 300, maxHeight: 300)
                     .onTapGesture {
                         shouldPresentSheet = true
                     }
            } placeholder: {
                ProgressView()
            }
        }
    }

    @ViewBuilder
    func FullImageSheet(imageUrl: String?) -> some View {
        if let imageUrl = URL(string: imageUrl ?? "") {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fit)
                     .edgesIgnoringSafeArea(.all)
            } placeholder: {
                ProgressView()
            }
        }
    }
}
