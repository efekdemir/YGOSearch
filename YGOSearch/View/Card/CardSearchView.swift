//
//  ContentView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/28/23.
//

import SwiftUI

struct CardSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = CardViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("🔍 Search card", text: $searchText, onCommit: {
                    viewModel.loadCardData(searchText)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Spacer()
                
                
                if let card = viewModel.card {
                    CardView(card: card)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    Text("Name must be correctly written (i.e. Blue-Eyes White Dragon)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.bottom)
                }
            }
            .navigationBarTitle("Search Menu", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack(spacing: 2) {
                    Image(systemName: "chevron.left.circle")
                    Text("Main Menu")
                }
                .foregroundColor(.blue)
            })
        }
    }
}

#Preview {
    CardSearchView()
}
