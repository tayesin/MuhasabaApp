//
//  mathuratCard.swift
//  Al Mathurat
//
//  Created by Tahasin Rahman on 12/26/23.
//

import SwiftUI

struct MathuratCardView: View {
    @Bindable var card: MathuratCardData
    @Bindable var userSettings: UserSettings

    @State var showingTransliteration = false
    @State var showingTranslation = true
    
    var body: some View {
        ZStack {
            VStack {
                Text(card.title)
                    .font(Font.custom("Kadwa", size: 25))
                    .padding(.bottom)
                if card.hasNight  && userSettings.isNight {
                    Text(card.nightText).font(Font.custom("Kitab", size: 20))
                        .lineSpacing(15)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .padding(.bottom)
                    if userSettings.showTransliteration {
                        Text(card.transliteration)
                            .font(Font.custom("Heebo", size: 20))
                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            .padding(.bottom)
                    }
                    if userSettings.showTranslation {
                        Text(card.nightTranslation)
                            .font(Font.custom("Habibi", size: 15))
                            .foregroundStyle(Color.black)
                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    }

                } else {
                    Text(card.arabicText).font(Font.custom("Kitab", size: 20))
                        .lineSpacing(15)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .padding(.bottom)
                    if userSettings.showTransliteration {
                        Text(card.transliteration)
                            .font(Font.custom("Heebo", size: 20))
                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            .padding(.bottom)
                    }
                    if userSettings.showTranslation {
                        Text(card.translation)
                            .font(Font.custom("Habibi", size: 15))
                            .foregroundStyle(Color.black)
                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    }
                }
                //Buttons
                HStack(spacing: 90) {
                    
                    //In the future add different translations?
//                    Menu {
//                        Button {
//
//                        } label: {
//                            Label("Show transliteration", systemImage: "heart")
//                        }
//                    } label: {
//                        Image(systemName: "slider.horizontal.3")
//                            .padding()
//                    }
                    Spacer()
                    //Add a play button
//                    Image(systemName: "play.circle")
//                        .padding()

//                    NavigationLink(destination: cardNoteView(card: card)) {
//                        Image(systemName: "square.and.pencil")
//                            .tint(Color.black)
//                    }
                }
            }
        }
        .padding()
        .frame(width: 375)
        .background(myColors().AliceBlue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 4, y: 3)
    }
}

struct cardNoteView: View {
    @Bindable var card: MathuratCardData
    var body: some View {
        Text("\(card.title)")
        Text("\(card.notes)")
    }
}


#Preview {
//    var newCard: MathuratCardData = MathuratCardData(title: "Al Ikhlas", arabicText: "قُلْ هُوَ اللَّهُ أَحَدٌ ‎﴿١﴾‏ اللَّهُ الصَّمَدُ ‎﴿٢﴾‏ لَمْ يَلِدْ وَلَمْ يُولَدْ ‎﴿٣﴾‏ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ ‎﴿٤﴾", transliteration: "qulhuAllahu ahad", translation: "say Allah is one")
    MathuratCardView(card: MathuratCardData(title: "Al Ikhlas", arabicText: "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ‎﴿١﴾‏ الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ ‎﴿٢﴾‏ الرَّحْمَٰنِ الرَّحِيمِ ‎﴿٣﴾‏ مَالِكِ يَوْمِ الدِّينِ ‎﴿٤﴾‏ إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ‎﴿٥﴾‏ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ ‎﴿٦﴾‏ صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ ‎﴿٧﴾", transliteration: "qulhuAllahu ahad", translation: "say Allah is one"), userSettings: UserSettings())
}
