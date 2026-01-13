//
//  Habit.swift
//  MuhasabaApp
//
//  Created by Tahasin Rahman on 1/9/26.
//

import Foundation
import SwiftData

@Model
class Habit {
    var habitName: String
    var id: String
    /// "YYYYMMDD" → completed or not
    var completedDays: [Int]

    init(habitName: String = "") {
        self.id = UUID().uuidString
        self.habitName = habitName
        self.completedDays = []
    }

    func markCompleted(on date: Date = Date()) {
        let key = Self.dayKeyInt(from: date)
        if !completedDays.contains(key) {
            completedDays.append(key)
            completedDays.sort()
        }
    }
    
    func markIncomplete(on date: Date = Date()) {
        let key = Self.dayKeyInt(from: date)
        completedDays.removeAll { $0 == key }
    }

    func isCompleted(on date: Date = Date()) -> Bool {
        completedDays.contains(Self.dayKeyInt(from: date))
    }

    private static func dayKeyInt(from date: Date) -> Int {
        let cal = Calendar.current
        let c = cal.dateComponents([.year, .month, .day], from: date)
        return (c.year! * 10_000) + (c.month! * 100) + c.day!
    }
}

@Model
class AllHabits {
    @Attribute(.unique) var singletonKey: String
    @Relationship(deleteRule: .cascade) var habits: [Habit]
    
    init(habits: [Habit] = []) {
        self.singletonKey = "singleton"
        if habits.isEmpty {
            self.habits = [
                Habit(habitName: "Fajr"),
                Habit(habitName: "Dhuhr"),
                Habit(habitName: "Asr"),
                Habit(habitName: "Maghrib"),
                Habit(habitName: "Isha"),
                Habit(habitName: "Mathurat"),
                Habit(habitName: "Tahajjud"),
                Habit(habitName: "Quran")
            ]
        } else {
            self.habits = habits
        }
    }
}

@Model
class DailySummary {
    @Attribute(.unique) var dayKey: Int   // YYYYMMDD
    var completedCount: Int
    var totalCount: Int

    init(dayKey: Int, completedCount: Int, totalCount: Int) {
        self.dayKey = dayKey
        self.completedCount = completedCount
        self.totalCount = totalCount
    }

    var score: Double {
        totalCount == 0 ? 0 : Double(completedCount) / Double(totalCount)
    }
}
