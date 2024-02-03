//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 06/01/2024.
//

    import Foundation
    import Combine




    class CoinDetailDataService {
        @Published var coinDetails: CoinDetailModel? = nil
        
        var coinDetailSubscribtion : AnyCancellable?
        let coin: CoinModel
        
        init(coin: CoinModel) {
            self.coin = coin
            getCoinsDetails()
        }
        
         func getCoinsDetails() {
            
             guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {return}
            
            
            coinDetailSubscribtion  = NetworkingManager.download(url: url)
                .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnCoinsDetails in
                    self?.coinDetails = returnCoinsDetails
                    self?.coinDetailSubscribtion?.cancel()
                })
        }
    }
    
    
    
    

