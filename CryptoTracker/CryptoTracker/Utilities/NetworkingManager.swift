//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 22/12/2023.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badUrlResponse(url: URL)
        case unKnown
        
        var errorDescription: String? {
            switch self {
            case .badUrlResponse( let url): return "Bad response from Url🔻🔻\(url)"
                
            case .unKnown: return "unKnown Error occured🔻🔻🔻"
                
            }
        }
    }
    
    static func download (url: URL) -> AnyPublisher<Data , Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleErrorResponse(output: $0 , url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleErrorResponse(output: URLSession.DataTaskPublisher.Output , url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badUrlResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion:Subscribers.Completion<Error>) {
        switch completion {
            
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

