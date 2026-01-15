//
//  TitlePage.swift
//  Al Mathurat
//
//  Created by Tahasin Rahman on 12/24/23.
//

import SwiftUI
import SwiftData

struct TitlePage: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var isActive = false
    @State private var size = 0.95
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            MainPage()
        } else {
            ZStack {
                myColors().AliceBlue
                    .ignoresSafeArea()
                ZStack {
                    Image("newLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.4)) {
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    TitlePage()
}


