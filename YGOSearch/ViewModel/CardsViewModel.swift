//
//  CardsViewModel.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/12/24.
//

import Foundation
import Combine

import Combine

class CardsViewModel: ObservableObject {
    @Published var cards: [CardModel] = []
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    private var apiService: APIService

    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    func loadCardsData(_ searchTerm: String) {
        guard searchTerm.count >= 2 else {
            DispatchQueue.main.async {
                self.errorMessage = "Search term must be at least 2 characters long."
                self.cards = []
            }
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
                    DispatchQueue.main.async {
                        self?.errorMessage = "Failed to fetch cards: \(error.localizedDescription)"
                    }
                }
            }, receiveValue: { [weak self] filteredCards in
                DispatchQueue.main.async {
                    self?.cards = filteredCards
                }
            })
            .store(in: &cancellables)
    }


}