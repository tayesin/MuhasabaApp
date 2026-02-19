////
////  Habit.swift
////  MuhasabaApp
////
////  Created by Tahasin Rahman on 1/9/26.
////
//
//import Foundation
//import SwiftData
//
//@Model
//class Completion {
//    var dayKey: Int
//    var createdAt: Date
//
//    init(dayKey: Int, createdAt: Date = Date()) {
//        self.dayKey = dayKey
//        self.createdAt = createdAt
//    }
//}
//
//@Model
//class Habit {
//    var habitName: String
//    var id: String
//    var order: Int?
//
//    @Relationship(deleteRule: .cascade) var completions: [Completion]
//
//    init(habitName: String = "", order: Int = 0) {
//        self.id = UUID().uuidString
//        self.habitName = habitName
//        self.completions = []
//        self.order = order
//    }
//
//    func isCompleted(on date: Date = Date()) -> Bool {
//        let key = Self.dayKeyInt(from: date)
//        return completions.contains(where: { $0.dayKey == key })
//    }
//
//    func markCompleted(on date: Date = Date()) {
//        let key = Self.dayKeyInt(from: date)
//        guard !isCompleted(on: date) else { return }
//        completions.append(Completion(dayKey: key))
//    }
//
//    func markIncomplete(on date: Date = Date()) {
//        let key = Self.dayKeyInt(from: date)
//        completions.removeAll(where: { $0.dayKey == key })
//    }
//
//    private static func dayKeyInt(from date: Date) -> Int {
//        let cal = Calendar.current
//        let c = cal.dateComponents([.year, .month, .day], from: date)
//        return (c.year! * 10_000) + (c.month! * 100) + c.day!
//    }
//}
//
//@Model
//class AllHabits {
//    @Attribute(.unique) var singletonKey: String?
//    @Relationship(deleteRule: .cascade) var habits: [Habit]
//
//    init(habits: [Habit] = []) {
//        self.singletonKey = "singleton"
//        if habits.isEmpty {
//            self.habits = [
//                Habit(habitName: "Fajr", order: 0),
//                Habit(habitName: "Dhuhr", order: 1),
//                Habit(habitName: "Asr", order: 2),
//                Habit(habitName: "Maghrib", order: 3),
//                Habit(habitName: "Isha", order: 4),
//                Habit(habitName: "Mathurat", order: 5),
//                Habit(habitName: "Tahajjud", order: 6),
//                Habit(habitName: "Quran", order: 7)
//            ]
//        } else {
//            self.habits = habits
//        }
//    }
//}
//
//@Model
//class DailySummary {
//    @Attribute(.unique) var dayKey: Int
//    var completedCount: Int
//    var totalCount: Int
//
//    init(dayKey: Int, completedCount: Int, totalCount: Int) {
//        self.dayKey = dayKey
//        self.completedCount = completedCount
//        self.totalCount = totalCount
//    }
//
//    var score: Double {
//        totalCount == 0 ? 0 : Double(completedCount) / Double(totalCount)
//    }
//}

import Foundation
import SwiftData

enum HabitsSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Habit.self, AllHabits.self, DailySummary.self, Completion.self]
    }
    
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
        var order: Int = 0
    
        @Relationship(deleteRule: .cascade) var completions: [Completion]
    
        init(habitName: String = "", order: Int = 0) {
            self.id = UUID().uuidString
            self.habitName = habitName
            self.completions = []
            self.order = order
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
                    Habit(habitName: "Fajr", order: 0),
                    Habit(habitName: "Dhuhr", order: 1),
                    Habit(habitName: "Asr", order: 2),
                    Habit(habitName: "Maghrib", order: 3),
                    Habit(habitName: "Isha", order: 4),
                    Habit(habitName: "Mathurat", order: 5),
                    Habit(habitName: "Tahajjud", order: 6),
                    Habit(habitName: "Quran", order: 7)
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

}


enum HabitsSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Habit.self, AllHabits.self, DailySummary.self, Completion.self]
    }

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
}


enum HabitsMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] = [
        HabitsSchemaV1.self,
        HabitsSchemaV2.self
    ]

    static var stages: [MigrationStage] = [
        .custom(
            fromVersion: HabitsSchemaV1.self,
            toVersion: HabitsSchemaV2.self,
            willMigrate: { _ in },
            didMigrate: { context in
                let containers = try context.fetch(FetchDescriptor<HabitsSchemaV2.AllHabits>())
                for container in containers {
                    for (i, habit) in container.habits.enumerated() {
                        habit.order = i
                    }
                }
                try context.save()
            }
        )
    ]
}


// Models+Current.swift
typealias Habit = HabitsSchemaV2.Habit
typealias Completion = HabitsSchemaV2.Completion
typealias AllHabits = HabitsSchemaV2.AllHabits
typealias DailySummary = HabitsSchemaV2.DailySummary
