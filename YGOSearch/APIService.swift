//
//  APIService.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/28/23.
//

import Foundation
import Combine

class APIService {

    func fetchCardsDetails(for name: String, typeFilter: String? = nil) -> AnyPublisher<[CardModel], Error> {
        var urlComponents = URLComponents(string: "https://db.ygoprodeck.com/api/v7/cardinfo.php")
        var queryItems = [URLQueryItem(name: "fname", value: name)]

        if let typeFilter = typeFilter {
            queryItems.append(URLQueryItem(name: "type", value: typeFilter))
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
        let urlComponents = URLComponents(string: "https://db.ygoprodeck.com/api/v7/cardinfo.php")
        
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

    // Keep your mock data function as is if needed for testing
    func fetchMockCardDetails() -> Future<CardModel, Error> {
        return Future<CardModel, Error> { promise in
            let data = MockCardData.blueEyesWhiteDragon.data(using: .utf8)!
            do {
                let cardDetails = try JSONDecoder().decode(CardModel.self, from: data)
                promise(.success(cardDetails))
            } catch {
                promise(.failure(error))
            }
        }
    }
}


//class APIService {
//    
//    func fetchCardsDetails(for name: String) -> AnyPublisher<[CardModel], Error> {
//        var urlComponents = URLComponents(string: "https://db.ygoprodeck.com/api/v7/cardinfo.php")
//        urlComponents?.queryItems = [URLQueryItem(name: "fname", value: name)]
//        
//        guard let url = urlComponents?.url else {
//            fatalError("Invalid URL")
//        }
//        
////        print("Requesting: \(url)")
//        
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .handleEvents(receiveOutput: { response in
////                print("Received response: \(response.response)")
//            })
//            .map(\.data)
//            .handleEvents(receiveOutput: { data in
//                _ = String(data: data, encoding: .utf8) ?? "Failed to decode data"
////                print("Received data: \(rawString)")
//            })
//            .decode(type: ApiResponse.self, decoder: JSONDecoder())
//            .handleEvents(receiveOutput: { apiResponse in
////                print("Decoded response: \(apiResponse)")
//            }, receiveCompletion: { completion in
//                if case let .failure(error) = completion {
//                    print("Error: \(error)")
//                }
//            })
//            .map { $0.data }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//
//
//    
//    func fetchMockCardDetails() -> Future<CardModel, Error> {
//        return Future<CardModel, Error> { promise in
//            let data = MockCardData.blueEyesWhiteDragon.data(using: .utf8)!
//            do {
//                let cardDetails = try JSONDecoder().decode(CardModel.self, from: data)
//                promise(.success(cardDetails))
//            } catch {
//                promise(.failure(error))
//            }
//        }
//    }
//}

//class MockAPIService: APIService {
//    var card: CardModel?
//    var error: Error?
//
//    override func fetchCardDetails(for name: String) -> AnyPublisher<CardModel, Error> {
//        if let card = card {
//            return Just(card)
//                .setFailureType(to: Error.self)
//                .eraseToAnyPublisher()
//        } else if let error = error {
//            return Fail(error: error)
//                .eraseToAnyPublisher()
//        } else {
//            fatalError("MockAPIService needs either a card or an error set before calling fetchCardDetails")
//        }
//    }
//
//    override func fetchMockCardDetails() -> Future<CardModel, Error> {
//        if let card = card {
//            return Future { promise in promise(.success(card)) }
//        } else if let error = error {
//            return Future { promise in promise(.failure(error)) }
//        } else {
//            fatalError("MockAPIService needs either a card or an error set before calling fetchMockCardDetails")
//        }
//    }
//}

