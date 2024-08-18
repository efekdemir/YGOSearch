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
    @State private var showingShop = false 
    @AppStorage("favoriteCards") private var favoriteCardsData: Data = Data()
    
    @State private var isFavorite: Bool = false
    
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
        .navigationBarItems(trailing: HStack {
            favoriteButton
            shopButton
        })
        .onAppear {
            isFavorite = loadFavorites().contains(where: { $0.id == card.id })
        }
        .sheet(isPresented: $shouldPresentImageSheet) {
            if let fullImageUrl = URL(string: card.card_images[selectedImageIndex].image_url) {
                CardImageSheet(imageUrl: fullImageUrl, isPresented: $shouldPresentImageSheet)
            }
        }
        .sheet(isPresented: $showingShop) {
            CardShopView(card: card)
        }
    }
    
    private var favoriteButton: some View {
        Button(action: toggleFavorite) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .red : .gray)
                .imageScale(.large)
        }
    }
    
    private var shopButton: some View {
        Button(action: {
            showingShop = true
        }) {
            Image(systemName: "cart")
                .imageScale(.large)
                .foregroundColor(.green)
        }
    }
    
    func toggleFavorite() {
        var favorites = loadFavorites()
        if let index = favorites.firstIndex(where: { $0.id == card.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(card)
        }
        saveFavorites(favorites)
        isFavorite = favorites.contains(where: { $0.id == card.id })
    }
    
    func loadFavorites() -> [CardModel] {
        if let favorites = try? JSONDecoder().decode([CardModel].self, from: favoriteCardsData) {
            return favorites
        } else {
            return []
        }
    }
    
    func saveFavorites(_ cards: [CardModel]) {
        guard let data = try? JSONEncoder().encode(cards) else {
            print("Failed to encode card models")
            return
        }
        favoriteCardsData = data
    }
}
