//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 06/01/2024.
//

import Foundation
import Combine


class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistic:[statisticsModel] = []
    @Published var additionalStatistic:[statisticsModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil

    
    @Published var coin: CoinModel
    private var cancellabels = Set<AnyCancellable>()
    private let coinDetailService : CoinDetailDataService
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        
    }
    
    private func addSubscribers() {
        
        
        
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink {[weak self] returnedArrays in
                self?.overviewStatistic = returnedArrays.overview
                self?.additionalStatistic = returnedArrays.additional

            }
            .store(in: &cancellabels )
        
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                self?.coinDescription = returnedCoinDetails?.readableDiscription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellabels)
        
        
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel? , coinModel: CoinModel) -> (overview: [statisticsModel], additional: [statisticsModel]) {
        
        // overview
            let price = coinModel.currentPrice.asCurrencyWith6Decimals()
            let priceChange = coinModel.priceChangePercentage24H
            let priceStat = statisticsModel(title: "Current Price", value: price , precentageChange: priceChange)
            
            let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
            let marketCapPrecentageChange = coinModel.marketCapChange24H
            let marketCapStat = statisticsModel(title: "Market Captilization", value: marketCap, precentageChange: marketCapPrecentageChange)
            
            let rank = "\(coinModel.rank)"
            let rankStat = statisticsModel(title: "Rank", value: rank)
            
            let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
            let volumeStat = statisticsModel(title: "Volume", value: volume)
            
            let overviewArray: [statisticsModel] = [
            priceStat,marketCapStat,rankStat,volumeStat
            ]
            
            // additional
            let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
            let highStat = statisticsModel(title: "24h High", value: high)
            
            let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
            let lowStat = statisticsModel(title: "24h Low", value: low)
            
            let priceChange2 = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
            let pricePercentChange2 = coinModel.priceChangePercentage24H
            let priceChangeStat = statisticsModel(title: "24h Price Change", value: priceChange2, precentageChange: pricePercentChange2 )
            
            let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
            let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
            let marketCapChangeStat = statisticsModel(title: "24h Market Cap Change", value: marketCapChange, precentageChange: marketCapPercentChange2)
            
            let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
            let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
            let blockStat = statisticsModel(title: "Block Time", value: blockTimeString)
            
            let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
            let hashingStat = statisticsModel(title: "Hashing Algorithm", value: hashing)
            
            let additionalArray: [statisticsModel] = [
                highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
            ]
            
            return (overviewArray,additionalArray)
        
        
    }
}
