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
    @Published var isLoading: Bool = false
    @Published var selectedAttributes: Set<String> = []
    @Published var selectedTypes: Set<String> = []
    @Published var selectedRaces: Set<String> = []
    @Published var selectedSpellTraps: Set<String> = []
    @Published var selectedLevels: Set<Int> = []
    @Published var selectedLinkRatings: Set<Int> = []
    @Published var attackValue: String = ""
    @Published var defenseValue: String = ""
    @Published var attackCondition: String = ">"
    @Published var defenseCondition: String = ">"
    
    private var cancellables = Set<AnyCancellable>()
    private var apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        self.loadAllCards()
    }
    
    func loadAllCards() {
        self.isLoading = true
        apiService.fetchAllCards()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
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
        let filterConditions: [Bool] = [
            searchTerm.count >= 2,
            !selectedAttributes.isEmpty,
            !selectedTypes.isEmpty,
            !selectedRaces.isEmpty,
            !selectedSpellTraps.isEmpty,
            !selectedLevels.isEmpty,
            !selectedLinkRatings.isEmpty,
            !attackValue.isEmpty,
            !defenseValue.isEmpty
        ]
        
        guard filterConditions.contains(true) else {
            errorMessage = "Search term must be at least 2 characters long or a filter must be active"
            showError = true
            cards = []
            return
        }
        
        self.isLoading = true
        var typeFilter: String? = nil
        if !selectedTypes.isEmpty {
            typeFilter = selectedTypes.joined(separator: ",")
        }
        
        apiService.fetchCardsDetails(for: searchTerm, typeFilter: typeFilter)
            .map { [weak self] cards in
                guard let self = self else { return [] }
                return cards.filter { card in
                    self.matchesFilters(card: card)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
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
    
    func resetFilters() {
        selectedAttributes.removeAll()
        selectedTypes.removeAll()
        selectedRaces.removeAll()
        attackValue = ""
        defenseValue = ""
        attackCondition = ">"
        defenseCondition = ">"
        selectedLevels = []
        selectedLinkRatings = []
        loadAllCards()
    }
    
    func matchesFilters(card: CardModel) -> Bool {
        if !selectedTypes.isEmpty && !selectedTypes.contains(card.type) {
            return false
        }
        
        if !selectedRaces.isEmpty && !selectedRaces.contains(card.race) {
            return false
        }
        
        if !selectedSpellTraps.isEmpty && !selectedSpellTraps.contains(card.humanReadableCardType) {
            return false
        }
        
        if !selectedAttributes.isEmpty && card.type.contains("Monster") {
            guard let attribute = card.attribute else { return false }
            if !selectedAttributes.contains(attribute) {
                return false
            }
        } else if !selectedAttributes.isEmpty {
            return false
        }
        
        if !attackValue.isEmpty && card.type.contains("Monster") {
            guard let atk = card.atk, atk != -1 else { return false }
            let attackValueInt = Int(attackValue) ?? 0
            switch attackCondition {
            case ">": if !(atk > attackValueInt) { return false }
            case "<": if !(atk < attackValueInt) { return false }
            case "=": if !(atk == attackValueInt) { return false }
            default: break
            }
        } else if !attackValue.isEmpty {
            return false
        }
        
        if !defenseValue.isEmpty && card.type.contains("Monster") && !card.type.contains("Link") {
            guard let def = card.def, def != -1 else { return false }
            let defenseValueInt = Int(defenseValue) ?? 0
            switch defenseCondition {
            case ">": if !(def > defenseValueInt) { return false }
            case "<": if !(def < defenseValueInt) { return false }
            case "=": if !(def == defenseValueInt) { return false }
            default: break
            }
        } else if !defenseValue.isEmpty {
            return false
        }
        
        let levelMatches = selectedLevels.isEmpty || (card.type.contains("Monster") && card.level.map(selectedLevels.contains) == true)
        
        let linkRatingMatches = selectedLinkRatings.isEmpty || (card.type == "Link Monster" && card.linkval.map(selectedLinkRatings.contains) == true)
        
        return (selectedLevels.isEmpty || levelMatches) && (selectedLinkRatings.isEmpty || linkRatingMatches)
    }
}
