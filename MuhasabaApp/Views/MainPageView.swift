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
            TablePage()
                .tabItem {
                    Image(systemName: "tablecells")
                    Text("Muhasaba Table")
                }
            MathuratPage()
                .environment(view)
                .tabItem {
                    Image("duahands.SFSymbol")
                    Text("Mathurat Duas")
                }
        }
    }
}

#Preview {
    MainPage()
}
