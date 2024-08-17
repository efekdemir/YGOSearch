//
//  CardImagesTabView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/14/24.
//

import SwiftUI

struct CardImagesTabView: View {
    let card: CardModel
    @Binding var selectedImageIndex: Int
    @Binding var shouldPresentImageSheet: Bool

    var body: some View {
        let cardImages = card.card_images

        TabView(selection: $selectedImageIndex) {
            ForEach(cardImages.indices, id: \.self) { index in
                if let imageCroppedUrl = URL(string: cardImages[index].image_url_cropped) {
                    AsyncImage(url: imageCroppedUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .onTapGesture {
                                shouldPresentImageSheet = true
                            }
                            .tag(index)
                    } placeholder: {
                        if let imageUrl = URL(string: cardImages[index].image_url) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
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
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(height: cardImages.count > 0 && card.type.contains("Pendulum Effect Monster") ? 500 : 400)
    }
}
