//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 24/12/2023.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var vm : HomeViewModel
    
    @Binding var showPortofolio: Bool
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                statisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width ,
               alignment: showPortofolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortofolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
