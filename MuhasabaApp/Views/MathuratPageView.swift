//
//  MathuratPage.swift
//  Al Mathurat
//
//  Created by Tahasin Rahman on 12/26/23.
//

import SwiftUI

struct MathuratPage: View {
    @State var sidebarShowing: Bool = false
    @State var infoScreen = false
    @State var showTransliteration = false
    @State var showTranslation = true
    @Environment(ViewModel.self) private var viewModel
    

    var body: some View {
        ZStack {
            NavigationStack {
                    ScrollView {
                        Text("Al Mathurat")
                            .font(
                                Font.custom("Kadwa", size: 35)
                            .weight(.bold))
                            .padding()
                            .toolbar {
                                ToolbarItem(placement: .topBarLeading) {
                                    Button(action: {
                                        sidebarShowing.toggle()}) {
                                            Image(systemName:
                                                "text.justify")
                                                .tint(Color.black)
                                                .padding()
                                        }
                                }
                                ToolbarItem(placement: .topBarTrailing) {
                                    Button(action: {
                                        infoScreen.toggle()}) {
                                            Image(systemName: "info.circle")
                                                    .tint(Color.black)
                                                    .padding()
                                        }.sheet(isPresented: $infoScreen) {
                                            sheetView()}
                                }
                            }
                        ForEach(viewModel.mathuratcards, id: \.id) {card in
                            MathuratCardView(card: card, userSettings: viewModel.userSettings)
                                .padding(.bottom)
                                .padding(.bottom)
                        }
                    }
            }
            dimmedScreen(sidebarshowing: $sidebarShowing)
            GeometryReader {_ in
                ZStack {
                    NavigationStack {
                        SidebarPage(userSettings: viewModel.userSettings)
                    }
                }
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width * 0.7)
                .offset(x: sidebarShowing ? 0 : -UIScreen.main.bounds.width)
                .animation(.smooth, value: sidebarShowing)
            }
        }
    }
}


struct dimmedScreen: View {
    @Binding var sidebarshowing: Bool
    
    var body: some View {
        Rectangle()
            .ignoresSafeArea()
            .opacity(sidebarshowing ? 0.8: 0)
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: sidebarshowing)
            .onTapGesture {
                sidebarshowing.toggle()
            }
    }
}

struct SidebarPage: View {
    @Bindable var userSettings: UserSettings
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Toggle("Show transliteration", isOn: $userSettings.showTransliteration)
                    .padding()
                Toggle("Show translation", isOn: $userSettings.showTranslation)
                    .padding()
                Toggle("Night duas", isOn: $userSettings.isNight)
                    .padding()
            }
        }
        .navigationTitle("Settings")

    }
}

struct sheetView: View {
    var body: some View {
        VStack {
            Text("Salam and Welcome")
                .font(Font.custom("Kadwa", size: 30))
            Text("What is Al Mathurat?")
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .font(Font.custom("Habibi", size: 25))
                .padding(.bottom)
            Text("These are a collection of authentic duas found in the Sunnah which are to be recited every morning and evening. They strengthen a Muslim's taqwa and confidence in themselves.")
                .font(Font.custom("Heebo", size: 20)
                    .weight(.regular))
                .padding(.horizontal)
        }
    }
}


#Preview {
    MathuratPage()
        .environment(ViewModel())
}
