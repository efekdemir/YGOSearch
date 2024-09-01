//
//  FavoritesView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/17/24.
//›

import SwiftUI

struct FavoritesView: View {
    @AppStorage("favoriteCards") private var favoriteCardsData: Data = Data()
    
    var body: some View {
        NavigationView {
            List(loadFavorites(), id: \.id) { card in
                NavigationLink(destination: CardDetailView(card: card)) {
                    HStack {
                        if let imageUrl = URL(string: card.card_images.first?.image_url_cropped ?? "") {
                            AsyncImageView(url: imageUrl)
                                .frame(width: 50, height: 50, alignment: .topLeading)
                                .cornerRadius(5)
                                .clipped()
                        }
                        
                        Text(card.name).bold()
                            .adjustableFontSize()
                    }
                }
            }
            .navigationBarTitle("Favorites", displayMode: .inline)
        }
    }
    
    func loadFavorites() -> [CardModel] {
        guard let favorites = try? JSONDecoder().decode([CardModel].self, from: favoriteCardsData) else {
            return []
        }
        return favorites
    }
}