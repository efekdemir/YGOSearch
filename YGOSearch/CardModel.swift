//
//  CardModel.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/28/23.
//

struct ApiResponse: Codable {
    var data: [CardModel]
}

struct CardModel: Codable {
    var id: Int
    var name: String
    var type: String
    var desc: String
    var atk: Int?
    var def: Int?
    var level: Int?
    var race: String
    var attribute: String
    var archetype: String?
    var ygoprodeck_url: String?
    var card_sets: [CardSet]
    var card_images: [CardImage]
    var card_prices: [CardPrice]

    struct CardSet: Codable {
        var set_name: String
        var set_code: String
        var set_rarity: String
        var set_rarity_code: String
        var set_price: String
    }

    struct CardImage: Codable {
        var id: Int
        var image_url: String
        var image_url_small: String
        var image_url_cropped: String
    }

    struct CardPrice: Codable {
        var cardmarket_price: String
        var tcgplayer_price: String
        var ebay_price: String
        var amazon_price: String
        var coolstuffinc_price: String
    }
}


func createMockCardModel() -> CardModel {
    return CardModel(
        id: 123,
        name: "Blue-Eyes White Dragon",
        type: "Dragon/Effect",
        desc: "This legendary dragon is a powerful engine of destruction.",
        atk: 3000,
        def: 2500,
        level: 8,
        race: "Dragon",
        attribute: "LIGHT",
        archetype: "Blue-Eyes",
        ygoprodeck_url: "https://ygoprodeck.com/card/blue-eyes-white-dragon-7485",
        card_sets: [
            CardModel.CardSet(set_name: "Legend of Blue Eyes White Dragon", set_code: "LOB-001", set_rarity: "Ultra Rare", set_rarity_code: "(UR)", set_price: "29.99")
        ],
        card_images: [
            CardModel.CardImage(id: 123, image_url: "https://example.com/image.png", image_url_small: "https://example.com/image_small.png", image_url_cropped: "https://example.com/image_cropped.png")
        ],
        card_prices: [
            CardModel.CardPrice(cardmarket_price: "5.00", tcgplayer_price: "5.50", ebay_price: "6.00", amazon_price: "5.75", coolstuffinc_price: "4.99")
        ]
    )
}

