//
//  MuhasabaAppApp.swift
//  MuhasabaApp
//
//  Created by Tahasin Rahman on 12/19/24.
//

import SwiftUI
import SwiftData

@main
struct MuhasabaApp: App {
    var body: some Scene {
        WindowGroup {
            TitlePage()
        }
        .modelContainer(for: [Habit.self, AllHabits.self, DailySummary.self, Completion.self])
    }
}
