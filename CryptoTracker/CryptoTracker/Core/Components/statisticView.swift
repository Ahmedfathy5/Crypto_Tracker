//
//  statisticView.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 24/12/2023.
//

import SwiftUI

struct statisticView: View {
    
    let stat: statisticsModel
    
    var body: some View {
        VStack(alignment: .leading , spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.seconderyText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack {
                
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.precentageChange ?? 0) >= 0 ? 0 : 180 ))
                   
                Text(stat.precentageChange?.asPrecentString() ?? "")
                    .font(.caption.bold())
            }
            .foregroundColor((stat.precentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red )
            .opacity(stat.precentageChange == nil ? 0 : 1)
        }
    }
}

struct statisticView_Previews: PreviewProvider {
    static var previews: some View {
        statisticView(stat: dev.stat1)
    }
}
