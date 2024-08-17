//
//  CardsViewModel.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/28/23.
//

import Foundation
import Combine

import Combine

class CardViewModel: ObservableObject {
    @Published var cards: [CardModel] = []
    @Published var errorMessage: String?
    @Published var showError: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private var apiService: APIService

    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    func loadCardsData(_ searchTerm: String) {
        guard searchTerm.count >= 2 else {
            errorMessage = "Search term must be at least 2 characters long."
            showError = true
            cards = []
            return
        }

        apiService.fetchCardsDetails(for: searchTerm)
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
