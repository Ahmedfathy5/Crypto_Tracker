//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 21/12/2023.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingsCoulmn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftCoulmn
            Spacer()
            if showHoldingsCoulmn {
                centerCoulmn
            }
            rightCoulmn
        }
        .font(.subheadline)
        .background(Color.theme.background)
        
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin , showHoldingsCoulmn: true)
                .previewLayout(.sizeThatFits)

            CoinRowView(coin: dev.coin , showHoldingsCoulmn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}


extension CoinRowView {
    private var leftCoulmn : some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.seconderyText)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading , 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    private var centerCoulmn : some View {
        HStack(spacing: 0) {
                VStack(alignment: .trailing) {
                    Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                        .bold()
                    Text((coin.currentHoldings ?? 0).asNumberString())
                }
                .foregroundColor(Color.theme.accent)
            }
        }
    
    
    private var rightCoulmn: some View {
        HStack(spacing: 0) {
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .bold()
                    .foregroundColor(Color.theme.accent)
                
                Text(coin.priceChangePercentage24H?.asPrecentString() ?? "")
                    .foregroundColor(
                        (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                    )
            }
            .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
        }
    }
}
