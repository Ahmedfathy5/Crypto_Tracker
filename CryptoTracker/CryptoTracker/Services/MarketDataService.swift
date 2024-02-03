//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 24/12/2023.
//

import Foundation
import Combine

class MarketDataService: ObservableObject {
    @Published var marketData: MarketDataModel? = nil
    
    var marketDataSubscribtion : AnyCancellable?
    
    
    init() {
        getData()
    }
    
    func getData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {return}
        
        
       marketDataSubscribtion = NetworkingManager.download(url: url)
            .decode(type: GlopalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscribtion?.cancel()
            })
    }
}
