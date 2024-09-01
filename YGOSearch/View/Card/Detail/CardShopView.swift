//
//  CardShopView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/17/24.
//

import SwiftUI

struct CardShopView: View {
    var card: CardModel

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("API prices may not be up-to-date")) {
                    if let prices = card.card_prices.first {
                        shopLinkButton("CardMarket", url: urlForShop("https://www.cardmarket.com/en/YuGiOh/Products/Search?searchString=", cardName: card.name), price: prices.cardmarket_price)
                        shopLinkButton("TCGPlayer", url: urlForShop("https://www.tcgplayer.com/search/all/product?q=", cardName: card.name), price: prices.tcgplayer_price)
                        shopLinkButton("Ebay", url: urlForShop("https://www.ebay.com/sch/i.html?_nkw=", cardName: card.name), price: prices.ebay_price)
                        shopLinkButton("Amazon", url: urlForShop("https://www.amazon.com/s?k=", cardName: card.name), price: prices.amazon_price)
                        shopLinkButton("CoolStuffInc", url: urlForShop("https://www.coolstuffinc.com/main_search.php?pa=searchOnName&page=1&resultsPerPage=25&q=", cardName: card.name), price: prices.coolstuffinc_price)
                    }
                }
            }
            .navigationBarTitle("\(card.name)", displayMode: .inline)
        }
    }

    private func urlForShop(_ baseUrl: String, cardName: String) -> URL {
        let queryName = cardName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: baseUrl + queryName)!
    }

    @ViewBuilder
    private func shopLinkButton(_ shopName: String, url: URL, price: String) -> some View {
        Link(destination: url) {
            HStack {
                Text(shopName)
                Spacer()
                Text("$\(price)")
            }
        }
    }
}

struct CardShopView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleCard = CardModel(id: 1, name: "Blue-Eyes White Dragon", type: "Monster", frameType: "Normal", desc: "This legendary dragon is a powerful engine of destruction.", atk: 3000, def: 2500, level: 8, linkval: nil, race: "Dragon", attribute: "Light", archetype: "Blue-Eyes", ygoprodeck_url: nil, card_sets: nil, card_images: [], card_prices: [
            CardModel.CardPrice(cardmarket_price: "30.00", tcgplayer_price: "25.00", ebay_price: "35.00", amazon_price: "28.00", coolstuffinc_price: "32.00")
        ])
        CardShopView(card: exampleCard)
    }
}
