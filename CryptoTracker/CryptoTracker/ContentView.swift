//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 21/12/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack (spacing: 40){
                Text("Acccent color")
                    .foregroundColor(Color.theme.accent)
                
                Text("Secondery text color ")
                    .foregroundColor(Color.theme.seconderyText )
                
                Text(" red color")
                    .foregroundColor(Color.theme.red)
                
                Text(" Green color")
                    .foregroundColor(Color.theme.green)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
