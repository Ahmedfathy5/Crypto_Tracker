//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 25/12/2023.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container : NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities:[PortfolioEntity] = []
    
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading core data \(error.localizedDescription)")
            }
            self.getPortfoli()
        }
    }
    
    
    //MARK: - PUBLIC
    func updatePortfolio(coin: CoinModel , amount: Double) {
        // check if coin is already in portfolio
        if let entity = savedEntities.first(where: { savedEntity in
             savedEntity.coinID == coin.id
        }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
        }else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    //MARK: - PRIVATE
    private func getPortfoli() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio entities \(error.localizedDescription)")
        }
    }
    
    private func add(coin: CoinModel , amount : Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity , amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to core Data\(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfoli()
    }
    
}
