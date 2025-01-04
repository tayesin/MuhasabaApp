//
//  TasbeehPageView.swift
//  MuhasabaApp
//
//  Created by Tahasin Rahman on 12/21/24.
//

import SwiftUI

struct TasbeehPageView: View {
    @Environment(ViewModel.self) private var viewModel
    
    lazy var texts = viewModel.mathuratcards
    
    @State private var currentIndex: Int = 0
    @State private var counter: Int = 3
    @State private var hi: Int = 0
    
    var body: some View {
        ZStack {
            Color("Primarywhite").ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                oneTasbeeh(card: viewModel.mathuratcards[currentIndex], userSettings: viewModel.userSettings)
                
                Spacer()
                Text("\(counter)")
                    .font(.title)
                    .padding()
                Spacer()
                
            }
        }
        .navigationTitle("")
        .onTapGesture(count: 1) {handleTap()}
        .backgroundStyle(Color.blue)
        .padding()
    }

    
    // 3. Decrement the counter, switch text when it hits 0
         func handleTap() {
            if counter > 1 {
                // Decrement the counter if it’s above 1
                counter -= 1
            } else {
                // If the counter would hit 0, reset it and move to the next text
                counter = 3  // reset to starting value
                if currentIndex < viewModel.mathuratcards.count - 1 {
                    currentIndex += 1
                } else {
                    // Optional: if you're at the last text, do something else,
                    // such as restarting or disabling the button.
                    // For now, let's just reset to the first text
                    currentIndex = 0
                }
            }
        }
}

struct oneTasbeeh: View {
    @Bindable var card: MathuratCardData
    @Bindable var userSettings: UserSettings
    var body: some View {
        VStack {
            Text(card.title)
                .font(Font.custom("Kadwa", size: 25))
//                .padding(.bottom)
            if card.hasNight  && userSettings.isNight {
                Text(card.nightText).font(Font.custom("Kitab", size: 20))
                    .lineSpacing(15)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                
            } else {
                Text(card.arabicText).font(Font.custom("Kitab", size: 20))
                    .lineSpacing(15)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    TasbeehPageView()
        .environment(ViewModel())
}
