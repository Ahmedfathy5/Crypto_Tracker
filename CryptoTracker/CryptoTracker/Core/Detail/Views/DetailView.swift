//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 03/01/2024.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
    
}



struct DetailView: View {
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    private let coulmns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible()) ]
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    descriptionSelection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                    
                    
                    
                    
                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTraillingItems
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
            
        }
    }
}


extension DetailView {
    private var navigationBarTraillingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.seconderyText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
            
        }
    }
    private var overviewTitle: some View {
        Text("OverView")
            .font(.title.bold())
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title.bold())
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var descriptionSelection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.seconderyText)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less.." : "Read more..")
                            .font(.caption.bold())
                            .padding(.vertical, 4)
                    }
                    .foregroundColor(.blue)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
    }
    private var overviewGrid: some View {
        LazyVGrid(columns: coulmns,
                  alignment: .center,
                  spacing: 30,
                  pinnedViews: []) {
            ForEach(vm.overviewStatistic) { stat in
                statisticView(stat: stat)
            }
        }
    }
    private var additionalGrid: some View {
        LazyVGrid(columns: coulmns,
                  alignment: .center,
                  spacing: 30,
                  pinnedViews: []) {
            ForEach(vm.additionalStatistic) { stat in
                statisticView(stat: stat)
            }
        }
    }
    private var websiteSection: some View {
        VStack ( alignment: .leading, spacing: 20){
            if let websiteString = vm.websiteURL, let url = URL(string:websiteString) {
                Link("websire", destination: url)
            }
            if let redditString = vm.redditURL , let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
