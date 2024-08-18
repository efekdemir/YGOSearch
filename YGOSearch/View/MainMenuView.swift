//
//  MainMenuView.swift
//  YGO Search
//
//  Created by Efe Demir on 8/7/24.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        TabView {
            NavigationView {
                GeometryReader { geometry in
                    VStack {
                        Image("ygo")
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                        Spacer()
                        
                        Text("Created by Efe Demir")
                            .frame(width: geometry.size.width, alignment: .center)
                            .font(.footnote)
                            .padding(.bottom, geometry.safeAreaInsets.bottom)
                    }
                    .navigationBarTitle("Main Menu", displayMode: .inline)
                }
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            CardSearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
