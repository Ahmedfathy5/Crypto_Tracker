//
//  LaunchView.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 12/01/2024.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText: [String] = "Loading your portfolio....".map {String($0)}
    @State private var showoading: Bool = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding  var showLaunchView: Bool
    var body: some View {
        ZStack{
            Color.launch.background
                .ignoresSafeArea()
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            ZStack {
                if showoading {
                    //                    Text(loadingText.indices)
                    //                        .font(.headline)
                    //                        .foregroundColor(Color.launch.accent)
                    //                        .fontWeight(.heavy)
                    //
                    HStack (spacing: 0){
                        ForEach(loadingText.indices , id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .foregroundColor(Color.launch.accent)
                                .fontWeight(.heavy)
                                .offset(y: counter == index ? -15 : 0)
                        }
                        .transition(AnyTransition.scale.animation(.easeIn))
                    }
                }
            }
            .offset(y: 70)
        }
        .onAppear{
            showoading.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()){
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
