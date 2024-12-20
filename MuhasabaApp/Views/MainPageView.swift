//
//  MainPage.swift
//  Al Mathurat
//
//  Created by Tahasin Rahman on 8/18/24.
//

import SwiftUI

struct MainPage: View {
    var view = ViewModel()
    var body: some View {
        TabView {
            
            Text("Coming Soon")
//            TablePage()
//                .environment(view)
//                .tabItem {
//                    Image(systemName: "tablecells")
//                    Text("Muhasaba Table")
//                }
//            
            MathuratPage()
                .environment(view)
                .tabItem {
                    Image("duahands.SFSymbol")
                    Text("Mathurat Duas")
                }
            
//            Tab("Muhasaba Table", systemImage: "tablecells") {
//                TablePage()
//            }
//            Tab("Mathurat Duas", Image: "duahands") {
//                TablePage()
//            }
        }
    }
}

#Preview {
    MainPage()
}
