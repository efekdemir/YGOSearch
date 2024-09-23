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
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                        Spacer()
                    } else if viewModel.cards.isEmpty && !viewModel.isLoading {
                        emptyStateView
                    } else {
                        List(viewModel.cards, id: \.id) { card in
                            NavigationLink(destination: CardDetailView(card: card)) {
                                Text(card.name)
                                    .adjustableFontSize()
                            }
                            .padding(.vertical, 4)
                        }
                        .listStyle(PlainListStyle())
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
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
    
    var emptyStateView: some View {
        VStack {
            Spacer()
            
            Text("No cards found!")
                .font(.title2)
                .padding(.bottom, 10)
            
            Text("Try searching with different keywords or adjust the filters.")
                .font(.body)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}
