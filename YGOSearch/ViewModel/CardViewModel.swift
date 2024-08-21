//
//  CardsViewModel.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/28/23.
//

import Foundation
import Combine

class CardViewModel: ObservableObject {
    @Published var cards: [CardModel] = []
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    @Published var selectedTypes: Set<String> = []

    private var cancellables = Set<AnyCancellable>()
    private var apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        self.loadAllCards()
    }
    
    func loadAllCards() {
        apiService.fetchAllCards()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = "Failed to load cards: \(error.localizedDescription)"
                    self?.showError = true
                }
            }, receiveValue: { [weak self] cards in
                self?.cards = cards
                self?.showError = false
            })
            .store(in: &cancellables)
    }

    func loadCardsData(_ searchTerm: String) {
        guard searchTerm.count >= 2 || !selectedTypes.isEmpty else {
            errorMessage = "Search term must be at least 2 characters long or a filter must be active"
            showError = true
            cards = []
            return
        }

        var typeFilter: String? = nil
        if !selectedTypes.isEmpty {
            typeFilter = selectedTypes.joined(separator: ",")
        }

        apiService.fetchCardsDetails(for: searchTerm, typeFilter: typeFilter)
            .map { cards in
                cards.filter { card in
                    let searchTerms = searchTerm.lowercased().split(separator: " ")
                    return searchTerms.allSatisfy { term in
                        card.name.lowercased().contains(term)
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = "Couldn't find card: \(error.localizedDescription)"
                    self?.showError = true
                }
            }, receiveValue: { [weak self] filteredCards in
                self?.cards = filteredCards
            })
            .store(in: &cancellables)
    }
}
