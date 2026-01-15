//
//  Habit.swift
//  MuhasabaApp
//
//  Created by Tahasin Rahman on 1/9/26.
//

import Foundation
import SwiftData

@Model
class Completion {
    var dayKey: Int
    var createdAt: Date

    init(dayKey: Int, createdAt: Date = Date()) {
        self.dayKey = dayKey
        self.createdAt = createdAt
    }
}

@Model
class Habit {
    var habitName: String
    var id: String

    @Relationship(deleteRule: .cascade) var completions: [Completion]

    init(habitName: String = "") {
        self.id = UUID().uuidString
        self.habitName = habitName
        self.completions = []
    }

    func isCompleted(on date: Date = Date()) -> Bool {
        let key = Self.dayKeyInt(from: date)
        return completions.contains(where: { $0.dayKey == key })
    }

    func markCompleted(on date: Date = Date()) {
        let key = Self.dayKeyInt(from: date)
        guard !isCompleted(on: date) else { return }
        completions.append(Completion(dayKey: key))
    }

    func markIncomplete(on date: Date = Date()) {
        let key = Self.dayKeyInt(from: date)
        completions.removeAll(where: { $0.dayKey == key })
    }

    private static func dayKeyInt(from date: Date) -> Int {
        let cal = Calendar.current
        let c = cal.dateComponents([.year, .month, .day], from: date)
        return (c.year! * 10_000) + (c.month! * 100) + c.day!
    }
}

@Model
class AllHabits {
    @Attribute(.unique) var singletonKey: String?
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
    @Attribute(.unique) var dayKey: Int
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
