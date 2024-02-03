//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 23/12/2023.
//

import Foundation
import Combine
import SwiftUI



class CoinImageService: ObservableObject {
    
    @Published var image: UIImage? = nil
    private var ImageSubscribtion : AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName : String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage =  fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("retreive image from file manager")
        } else {
            downloadCoinImage()
            print("download image now")
        }
        
    }
    
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {return}
        
        
        ImageSubscribtion = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage?  in
                UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnImage in
                guard let self = self , let downloadImage = returnImage else {return}
                
                self.image = downloadImage
                self.ImageSubscribtion?.cancel()
                self.fileManager.saveImage(image: downloadImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
    
    
}
