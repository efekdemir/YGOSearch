//
//  CardSearchView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/28/23.
//
import SwiftUI
struct CardSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = CardViewModel()
    
    @State private var searchText = ""
    @State private var showingFilter = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchTextField(text: $searchText, onCommit: {
                    viewModel.loadCardsData(searchText)
                }, onFilter: {
                    showingFilter = true
                }, onReset: {
                    viewModel.loadAllCards()
                })
                
                List(viewModel.cards, id: \.id) { card in
                    NavigationLink(destination: CardDetailView(card: card)) {
                        Text(card.name)
                            .adjustableFontSize()
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(PlainListStyle())
                
                if viewModel.showError {
                    ErrorBanner(errorMessage: $viewModel.errorMessage, showError: $viewModel.showError)
                        .padding(.bottom)
                }
            }
            .navigationBarTitle("Search Menu", displayMode: .inline)
            .sheet(isPresented: $showingFilter) {
                FilterView(
                    selectedTypes: $viewModel.selectedTypes,
                    selectedRaces: $viewModel.selectedRaces, attackValue: $viewModel.attackValue,
                    defenseValue: $viewModel.defenseValue,
                    attackCondition: $viewModel.attackCondition,
                    defenseCondition: $viewModel.defenseCondition,
                    selectedLevels: $viewModel.selectedLevels,
                    selectedLinkRatings: $viewModel.selectedLinkRatings,
                    onApply: {
                        viewModel.loadCardsData(searchText)
                        showingFilter = false
                    },
                    onClose: {
                        viewModel.resetFilters()
                        showingFilter = false
                    }
                )
            }
        }
    }
}

