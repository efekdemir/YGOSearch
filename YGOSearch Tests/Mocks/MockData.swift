//
//  MockData.swift
//  YGOSearch
//
//  Created by Efe Demir on 6/14/24.
//

import Foundation

struct MockData {
    static func decodeMockCard(jsonString: String) -> CardModel {
        let jsonData = jsonString.data(using: .utf8)!
        do {
            let decoder = JSONDecoder()
            let cardModel = try decoder.decode(CardModel.self, from: jsonData)
            return cardModel
        } catch {
            fatalError("Failed to decode CardModel: \(error)")
        }
    }
    
    static let jarOfGreed = """
        {
          "id": 83968380,
          "name": "Jar of Greed",
          "type": "Trap Card",
          "frameType": "trap",
          "desc": "Draw 1 card.",
          "race": "Normal",
          "archetype": "Greed",
          "ygoprodeck_url": "https://ygoprodeck.com/card/jar-of-greed-7039",
          "card_sets": [
            {
              "set_name": "Dark Beginning 1",
              "set_code": "DB1-EN242",
              "set_rarity": "Rare",
              "set_rarity_code": "(R)",
              "set_price": "0"
            },
          ],
          "card_images": [
            {
              "id": 83968380,
              "image_url": "https://images.ygoprodeck.com/images/cards/83968380.jpg",
              "image_url_small": "https://images.ygoprodeck.com/images/cards_small/83968380.jpg",
              "image_url_cropped": "https://images.ygoprodeck.com/images/cards_cropped/83968380.jpg"
            }
          ],
          "card_prices": [
            {
              "cardmarket_price": "0.80",
              "tcgplayer_price": "1.40",
              "ebay_price": "3.95",
              "amazon_price": "3.05",
              "coolstuffinc_price": "1.99"
            }
          ]
        }
    """
    
    static let blueEyesWhiteDragon = """
    {
        "id": 89631139,
        "name": "Blue-Eyes White Dragon",
        "type": "Normal Monster",
        "frameType": "normal",
        "desc": "This legendary dragon is a powerful engine of destruction. Virtually invincible, very few have faced this awesome creature and lived to tell the tale.",
        "atk": 3000,
        "def": 2500,
        "level": 8,
        "race": "Dragon",
        "attribute": "LIGHT",
        "archetype": "Blue-Eyes",
        "ygoprodeck_url": "https://ygoprodeck.com/card/blue-eyes-white-dragon-7485",
        "card_sets": [
            {
                "set_name": "2016 Mega-Tins",
                "set_code": "CT13-EN008",
                "set_rarity": "Ultra Rare",
                "set_rarity_code": "(UR)",
                "set_price": "74.49"
            },
        ],
        "card_images": [
            {
                "id": 89631139,
                "image_url": "https://images.ygoprodeck.com/images/cards/89631139.jpg",
                "image_url_small": "https://images.ygoprodeck.com/images/cards_small/89631139.jpg",
                "image_url_cropped": "https://images.ygoprodeck.com/images/cards_cropped/89631139.jpg"
            },
        ],
        "card_prices": [
            {
                "cardmarket_price": "0.33",
                "tcgplayer_price": "0.36",
                "ebay_price": "5.95",
                "amazon_price": "3.90",
                "coolstuffinc_price": "0.99"
            }
        ]
    }
    """
}
