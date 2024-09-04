//
//  MainMenuView.swift
//  YGO Search
//
//  Created by Efe Demir on 8/7/24.
//

import SwiftUI

struct MainMenuView: View {
    @State private var showEasterEgg = false
    
    var body: some View {
        TabView {
            NavigationView {
                GeometryReader { geometry in
                    VStack {
                        Logo()
                            .padding()
                        
                        Spacer()
                        
                        Text("Created by Efe Demir")
                            .frame(width: geometry.size.width, alignment: .center)
                            .font(.footnote)
                            .padding(.bottom, geometry.safeAreaInsets.bottom)
                            .onTapGesture(count: 2) {
                                self.showEasterEgg.toggle()
                            }
                    }
                    .navigationBarTitle("Main Menu", displayMode: .inline)
                    .sheet(isPresented: $showEasterEgg) {
                        EfeDemir()
                    }
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
