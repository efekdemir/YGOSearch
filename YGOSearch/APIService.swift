//
//  APIService.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/28/23.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func fetchAllCards() -> AnyPublisher<[CardModel], Error>
    func fetchCardsDetails(for name: String, typeFilter: String?) -> AnyPublisher<[CardModel], Error>
    func fetchBanlistCards(for banlist: String) -> AnyPublisher<[CardModel], Error>
}

class APIService: APIServiceProtocol {
    private var selectedLanguage: String {
        UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
    }

    func fetchCardsDetails(for name: String, typeFilter: String? = nil) -> AnyPublisher<[CardModel], Error> {
        var urlComponents = URLComponents(string: "https://db.ygoprodeck.com/api/v7/cardinfo.php")
        var queryItems = [URLQueryItem(name: "fname", value: name)]

        if let typeFilter = typeFilter {
            queryItems.append(URLQueryItem(name: "type", value: typeFilter))
        }

        if selectedLanguage != "en" {
            queryItems.append(URLQueryItem(name: "language", value: selectedLanguage))
        }
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ApiResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchAllCards() -> AnyPublisher<[CardModel], Error> {
        var urlComponents = URLComponents(string: "https://db.ygoprodeck.com/api/v7/cardinfo.php")
        
        var queryItems: [URLQueryItem] = []

        if selectedLanguage != "en" {
            queryItems.append(URLQueryItem(name: "language", value: selectedLanguage))
        }

        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ApiResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchBanlistCards(for banlist: String) -> AnyPublisher<[CardModel], Error> {
        var urlComponents = URLComponents(string: "https://db.ygoprodeck.com/api/v7/cardinfo.php")
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "banlist", value: banlist)
        ]
        
        if selectedLanguage != "en" {
            urlComponents?.queryItems?.append(URLQueryItem(name: "language", value: selectedLanguage))
        }
        
        guard let url = urlComponents?.url else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ApiResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetchMockCardDetails() -> Future<CardModel, Error> {
        return Future<CardModel, Error> { promise in
            let data = MockData.blueEyesWhiteDragon.data(using: .utf8)!
            do {
                let cardDetails = try JSONDecoder().decode(CardModel.self, from: data)
                promise(.success(cardDetails))
            } catch {
                promise(.failure(error))
            }
        }
    }
}
