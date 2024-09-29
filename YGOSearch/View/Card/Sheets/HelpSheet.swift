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
            Spacer()
            TabView(selection: $currentPage) {
                HelpPage(imageName: "ygo", title: "Welcome to YGO Search!", summary: "Here is a quick tutorial :)")
                    .tag(0)
                
                HelpPage(imageName: "Help1", title: "Search Menu", summary: "Look for cards here.", description: "Freely scroll through all the cards, or use the search bar or the filter button to find specific cards. Once you have found your card, simply tap on it to see its details.")
                    .tag(1)
                
                HelpPage(imageName: "Help2", title: "Filter Sheet", summary: "Narrow down your search by using the filters here.", description: "However, make sure that your filters don't contradict one another (i.e. selecting Beast-Warrior in the Monster Races filter and Ritual Spell in the Spells & Traps filter as no card can match both of those filters).")
                    .tag(2)
                
                HelpPage(imageName: "Help3", title: "Card Details", summary: "View a card's details such as its effect, type, or image.", description: "You can tap on the image to see it in full size or zoom on specific parts. Some cards may have alternate artworks, which you can slide through as well. On the top right of the screen, you can add the card to your Favorites (heart) or look into its prices (shopping cart).")
                    .tag(3)
                
                HelpPage(imageName: "Help4", title: "Card Prices", summary: "Click on a store here to be redirected to that store's website where you can buy a card.")
                    .tag(4)
                
                HelpPage(imageName: "Help5", title: "Favorites Menu", summary: "Access your favorite cards with ease on this page (you need to favorite them first).")
                    .tag(5)
                
                HelpPage(imageName: "Help6", title: "Banlist Menu", summary: "Browse the currently banned cards here.", description: "You can toggle between which banlist you want to explore and switch between Forbidden, Limited, and Semi-Limited cards. Note that the filters from your Search Menu will carry over to the Banlist Menu as well.")
                    .tag(6)
                
                HelpPage(imageName: "Help7", title: "Settings Menu", summary: "Customize your YGO Search experience here.", description: "Toggle between light and dark mode, increase/decrease text font size, or change the language of the cards.")
                    .tag(7)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
            .frame(height: UIScreen.main.bounds.height * 0.8) // Adjust frame height to push content up
            
            Button(action: {
                if currentPage == 7 {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    withAnimation {
                        currentPage += 1
                    }
                }
            }) {
                Text(currentPage == 7 ? "Get Started" : "Next")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 40)
            }
            .padding(.bottom, 20)
        }
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}


struct HelpPage: View {
    var imageName: String
    var title: String
    var summary: String
    var description: String?
    
    var body: some View {
        VStack(spacing: 16) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 400)
                .padding()
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text(summary)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(3)
                .minimumScaleFactor(0.3)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if let description = description {
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .frame(maxWidth: 600)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .padding()
    }
}
