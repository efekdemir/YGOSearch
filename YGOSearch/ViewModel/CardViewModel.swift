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
    @Published var selectedRaces: Set<String> = []
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
        let filterConditions: [Bool] = [
            searchTerm.count >= 2,
            !selectedTypes.isEmpty,
            !selectedRaces.isEmpty,
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


// this one also accounts for selecting link rating and levels combined but is messier
//    func matchesFilters(card: CardModel) -> Bool {
//        var matches = true
//        var levelMatches = false
//        var linkRatingMatches = false
//
//        if !selectedTypes.isEmpty && !selectedTypes.contains(card.type) {
//            matches = false
//        }
//
//        if !attackValue.isEmpty {
//            if card.type.contains("Monster") {
//                if let atk = card.atk {
//                    if atk != -1  {
//                        switch attackCondition {
//                        case ">":
//                            matches = matches && atk > Int(attackValue) ?? 0
//                        case "<":
//                            matches = matches && atk < Int(attackValue) ?? 0
//                        case "=":
//                            matches = matches && atk == Int(attackValue) ?? 0
//                        default:
//                            break
//                        }
//                    }
//                }
//            } else {
//                matches = false
//            }
//        }
//
//        if !defenseValue.isEmpty {
//            if card.type.contains("Monster") && !card.type.contains("Link") {
//                if let def = card.def {
//                    if def != -1  {
//                        switch defenseCondition {
//                        case ">":
//                            matches = matches && def > Int(defenseValue) ?? 0
//                        case "<":
//                            matches = matches && def < Int(defenseValue) ?? 0
//                        case "=":
//                            matches = matches && def == Int(defenseValue) ?? 0
//                        default:
//                            break
//                        }
//                    } else {
//                        matches = false
//                    }
//                }
//            } else {
//                matches = false
//            }
//        }
//
//        if !selectedLevels.isEmpty {
//            if card.type.contains("Monster"), let level = card.level {
//                levelMatches = selectedLevels.contains(level)
//            } else {
//                matches = false
//            }
//        } else {
//            levelMatches = true
//        }
//
//        if !selectedLinkRatings.isEmpty {
//            if card.type == "Link Monster", let linkRating = card.linkval {
//                linkRatingMatches = selectedLinkRatings.contains(linkRating)
//            } else {
//                matches = false
//            }
//        } else {
//            linkRatingMatches = true
//        }
//
//        if !selectedRaces.isEmpty && !selectedRaces.contains(card.race) {
//            matches = false
//        }
//
//        if !selectedLevels.isEmpty && !selectedLinkRatings.isEmpty && !attackValue.isEmpty {
//            return matches && (levelMatches || linkRatingMatches)
//        }
//
//        if !selectedLevels.isEmpty && !selectedLinkRatings.isEmpty {
//            return levelMatches || linkRatingMatches
//        } else {
//            return matches && levelMatches && linkRatingMatches
//        }
//    }
