//
//  CardListViewModel.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/28/23.
//

import Foundation
import Combine

class CardListViewModel: ObservableObject {
    @Published var card: CardModel?
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()

    private var apiService: APIService

    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    func loadCardData(_ searchTerm: String) {
        apiService.fetchCardDetails(for: searchTerm)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.errorMessage = "Failed to fetch card: \(error.localizedDescription)"
                    }
                }
            }, receiveValue: { [weak self] card in
                DispatchQueue.main.async {
                    self?.card = card
                }
            })
            .store(in: &self.cancellables)
    }
    

    func loadMockCardData() {
        apiService.fetchMockCardDetails()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching card details: \(error)")
                }
            }, receiveValue: { [weak self] cardDetails in
                self?.card = cardDetails
            })
            .store(in: &cancellables)
    }
}
