//
//  BanlistView.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/22/24.
//

import SwiftUI

struct BanlistView: View {
    @ObservedObject var viewModel = CardViewModel()
    
    @State private var selectedBanlist = "TCG"
    @State private var selectedGroup = "Forbidden"
    
    let banlistOptions = ["TCG", "OCG", "GOAT"]
    let groupOptions = ["Forbidden", "Limited", "Semi-Limited"]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Picker("Select Banlist", selection: $selectedBanlist) {
                        ForEach(banlistOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedBanlist) { newValue in
                        viewModel.loadBanlistCards(banlist: newValue.lowercased())
                    }
                    
                    Picker("Select Group", selection: $selectedGroup) {
                        ForEach(groupOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal)
                            
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading...")
                        .progressViewStyle(.circular)
                        .padding()
                } else if viewModel.cards.isEmpty && !viewModel.isLoading {
                    EmptyCardsView()
                } else {
                    List(filteredCards(), id: \.id) { card in
                        NavigationLink(destination: CardDetailView(card: card)) {
                            Text(card.name)
                                .adjustableFontSize()
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarTitle("Banlist", displayMode: .inline)
            .onAppear {
                viewModel.loadBanlistCards(banlist: selectedBanlist.lowercased())
            }
        }
    }
    
    func filteredCards() -> [CardModel] {
        return viewModel.cards.filter { card in
            let banlistInfo = card.banlist_info
            switch selectedBanlist {
            case "TCG":
                return banlistMatches(banlistInfo?.ban_tcg)
            case "OCG":
                return banlistMatches(banlistInfo?.ban_ocg)
            case "GOAT":
                return banlistMatches(banlistInfo?.ban_goat)
            default:
                return false
            }
        }
    }
    
    func banlistMatches(_ banStatus: String?) -> Bool {
        guard let banStatus = banStatus else { return false }
        return banStatus.caseInsensitiveCompare(selectedGroup) == .orderedSame
    }
}
