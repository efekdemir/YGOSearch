//
//  MainMenuView.swift
//  YGO Search
//
//  Created by Efe Demir on 8/7/24.
//

import SwiftUI

struct MainMenuView: View {
    @State private var showingCardSearch = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Image("ygo")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Button("Card Search") {
                        showingCardSearch = true
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding()
                    .padding()
                    
                    Spacer()
                    
                    Text("Created by Efe Demir")
                        .frame(width: geometry.size.width, alignment: .center)
                        .font(.footnote)
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                }
                .navigationBarTitle("Main Menu", displayMode: .inline)
                .fullScreenCover(isPresented: $showingCardSearch) {
                    CardSearchView()
                }
            }
        }
        
    }
}


#Preview {
    MainMenuView()
}
