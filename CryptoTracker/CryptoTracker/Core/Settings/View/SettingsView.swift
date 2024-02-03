//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 10/01/2024.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://api.whatsapp.com/send/?phone=201204315858&text&type=phone_number&app_absent=0")!
    
    var body: some View {
        NavigationView {
            List {
                DeveloperSection
             swiftfullthinkingView
                coinGecko
                appSection
                
            }
            .accentColor(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var swiftfullthinkingView: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine, and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
                
            }
            .padding(.vertical)
            Link("Subscribe on YouTube 🥳", destination: youtubeURL)
        } header: {Text("Swiftful Thinking")}
    }
    private var coinGecko: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame( height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
                
            }
            .padding(.vertical)
            Link("Visit Coin Gecko 🥳", destination: coingeckoURL)
        } header: {Text("Coin Gecko")}
    }
    
    private var DeveloperSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("123")
                    .resizable()
                    .scaledToFit()
                    .frame( height: 500)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by the LORD Ahmed fathy. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
                
            }
            .padding(.vertical)
            Link("Ahmed fathy's what's App 🥳", destination: personalURL)
        } header: {Text("Developer")}
    }
    private var appSection: some View {
        Section {
            Link("Visite Website🔻", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)

            Link("Company Website", destination: defaultURL)

            Link("Learn More", destination: defaultURL)

        } header: {
            Text("Application")
        }

    }
    
}
