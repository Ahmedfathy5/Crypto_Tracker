//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 22/12/2023.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    
    @Published var statistics : [statisticsModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var allCoins : [CoinModel] = []
    @Published var PortofolioCoins : [CoinModel] = []
    @Published var sortOption: sortOption = .holdings

    
    
    private var cancellabelles = Set<AnyCancellable>()
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    enum sortOption {
        case rank , rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        //MARK: - Filtering searching text && Updates all coins as well
        $searchText
            .combineLatest(coinDataService.$allCoins,$sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map (filterAndSortCoins)
            .sink {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellabelles)
        
        //MARK: - update Portfolio Coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self ] returnedCoins in
                guard let self = self else {return}
                self.PortofolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellabelles)
        
        //MARK: - Updates Market Data
        marketDataService.$marketData
            .combineLatest($PortofolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellabelles)
        
    }
    
    
    func updatePortofolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.Notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String , coins: [CoinModel] , sort: sortOption ) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortAllCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func filterCoins(text: String , coins: [CoinModel] )-> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) || coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func sortAllCoins(sort: sortOption, coins: inout [CoinModel]) {
        
        switch sort {
        case .rank ,.holdings :
             coins.sort(by: { $0.rank < $1.rank})
//           coins.sort { coin1, coin2 in
//                coin1.rank < coin2.rank
//            }
        case .rankReversed, .holdingsReversed:
             coins.sort(by: { $0.rank > $1.rank})
        case .price:
             coins.sort(by: { $0.currentPrice > $1.currentPrice})
        case .priceReversed:
             coins.sort(by: { $0.currentPrice < $1.currentPrice})
        }
        
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // Will only sort by holdings or reversedHoldeings if needed
        switch self.sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
            
        }
        
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities:[PortfolioEntity])-> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else { return nil}
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel? , PortofolioCoins: [CoinModel]) -> [statisticsModel] {
        var stats: [statisticsModel] = []
        
        guard let data = marketDataModel else { return stats }
        let marketCap = statisticsModel(title: "Market Cap", value: data.marketCap, precentageChange: data.marketCapChangePercentage24HUsd)
        let volume = statisticsModel(title: "24h Volume", value: data.volume)
        let percentage = statisticsModel(title: "BTC Doumanece", value: data.precenyage)
        
        let portofolioValue =
        PortofolioCoins
            .map { coin -> Double in
                coin.currentHoldingsValue
            }
            .reduce(0, +)
        
        let previousValue =
            PortofolioCoins
                .map { (coin) -> Double in
                    let currentValue = coin.currentHoldingsValue
                    let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                    let previousValue = currentValue / (1 + percentChange)
                    return previousValue
                }
                .reduce(0, +)

        let percentageChange = ((portofolioValue - previousValue) / previousValue)

            
        
        let portfolio = statisticsModel(title: "Portofolio Value", value: portofolioValue.asCurrencyWith2Decimals() , precentageChange: percentageChange)
        
        stats.append(contentsOf: [portfolio , percentage , volume , marketCap])
        return stats
        
    }
    

