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
        TabView {
            NavigationView {
                VStack {
                    SearchTextField(text: $searchText, onCommit: {
                        viewModel.loadCardsData(searchText)
                    }, onFilter: {
                        showingFilter = true
                    }, onReset: {
                        viewModel.loadAllCards()
                    })
                    
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView("Loading...")
                            .progressViewStyle(.circular)
                            .padding()
                        Spacer()
                    } else if viewModel.cards.isEmpty && !viewModel.isLoading {
                        EmptyCardsView()
                    } else {
                        List(viewModel.cards, id: \.id) { card in
                            NavigationLink(destination: CardDetailView(card: card)) {
                                Text(card.name)
                                    .adjustableFontSize()
                            }
                        }
                        .listStyle(.plain)
                    }
                    
                    if viewModel.showError {
                        ErrorBanner(errorMessage: $viewModel.errorMessage, showError: $viewModel.showError)
                            .padding(.bottom)
                    }
                }
                .navigationBarTitle("Search Menu", displayMode: .inline)
                .sheet(isPresented: $showingFilter) {
                    FilterView(
                        selectedAttributes: $viewModel.selectedAttributes,
                        selectedTypes: $viewModel.selectedTypes,
                        selectedRaces: $viewModel.selectedRaces,
                        selectedSpellTraps: $viewModel.selectedSpellTraps,
                        attackValue: $viewModel.attackValue,
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
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            
            BanlistView(viewModel: viewModel)
                .tabItem {
                    Label("Banlist", systemImage: "xmark.shield")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
