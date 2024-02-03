//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 23/12/2023.
//

import Foundation
import Combine
import SwiftUI

class CoinImageViewModel:ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    
    
    var cancellabelles = Set<AnyCancellable>()
    private let coin : CoinModel
    private let dataService : CoinImageService
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        
        dataService.$image
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                
            }
            .store(in: &cancellabelles)
        
        
    }
    
    
}
