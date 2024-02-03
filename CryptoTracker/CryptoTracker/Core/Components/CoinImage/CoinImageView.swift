//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 23/12/2023.
//

import SwiftUI





struct CoinImageView: View {
    
    @StateObject var vm : CoinImageViewModel
    
    init(coin: CoinModel ) {
       _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.seconderyText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
