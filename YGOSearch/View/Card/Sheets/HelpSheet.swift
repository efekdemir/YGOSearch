//
//  HelpSheet.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/28/24.
//

import SwiftUI

struct HelpSheet: View {
    @State private var currentPage = 0
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                HelpPage(imageName: "ygo", title: "Welcome to YGO Search!", description: "Here is a quick tutorial :)")
                    .tag(0)
                
                HelpPage(imageName: "Help1", title: "Search Menu", description: "Look for cards here. Freely scroll through all the cards, or use the search bar or the filter button to find specific cards. Once you have found your card, simply tap on it to see its details.")
                    .tag(1)
                
                HelpPage(imageName: "Help2", title: "Filter Sheet", description: "Narrow down your search by using the filters here. However, make sure that your filters don't contradict one another (i.e. selecting Beast-Warrior in the Monster Races filter and Ritual Spell in the Spells & Traps filter as no card can match both of those filters).")
                    .tag(2)
                
                HelpPage(imageName: "Help3", title: "Card Details", description: "View a card's details such as its effect, type, or image. You can tap on the image to see it in full size or zoom on specific parts. Some cards may have alternate artworks, which you can slide through as well. On the top right of the screen, you can add the card to your Favorites (heart) or look into its prices (shopping cart).")
                    .tag(3)
                
                HelpPage(imageName: "Help4", title: "Card Prices", description: "Click on a store here to be redirected to that store's website where you can buy a card.")
                    .tag(4)
                
                HelpPage(imageName: "Help5", title: "Favorites Menu", description: "Access your favorite cards with ease on this page (you need to favorite them first).")
                    .tag(5)
                
                HelpPage(imageName: "Help6", title: "Banlist Menu", description: "Browse the currently banned cards here. You can toggle between which banlist you want to explore and switch between Forbidden, Limited, and Semi-Limited cards. Note that the filters from your Search Menu will carry over to the Banlist Menu as well.")
                    .tag(6)
                
                HelpPage(imageName: "Help7", title: "Settings Menu", description: "Customize your YGO Search experience here. Toggle between light and dark mode, increase/decrease text font size, or change the language of the cards.")
                    .tag(7)
                
                
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            
            Button(action: {
                if currentPage == 7 {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    currentPage += 1
                }
            }) {
                Text(currentPage == 7 ? "Close" : "Next")
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct HelpPage: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.largeTitle)
                .bold()
            
            Text(description)
                .font(.body)
                .frame(alignment: .center)
                .padding()
                .background(.gray)
                .foregroundColor(.white)
                .cornerRadius(10)

        }
        .padding()
    }
}
