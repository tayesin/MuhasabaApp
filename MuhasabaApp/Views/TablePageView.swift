//
//  TablePage.swift
//  Al Mathurat
//
//  Created by Tahasin Rahman on 8/18/24.
//

import SwiftUI
import SwiftData

private func dayKeyInt(from date: Date, calendar: Calendar = .current) -> Int {
    let c = calendar.dateComponents([.year, .month, .day], from: date)
    return (c.year! * 10_000) + (c.month! * 100) + c.day!
}

private func startOfMonth(for date: Date, calendar: Calendar) -> Date {
    let comps = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: comps)!
}

private func daysInMonth(for date: Date, calendar: Calendar) -> Int {
    calendar.range(of: .day, in: .month, for: date)!.count
}


struct TablePage: View {
//    @Environment(ViewModel.self) private var viewModel
    @Environment(\.modelContext) private var context
    
    @State private var timeRange: TimeRange = .day
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Muhasaba Table").font(Font.custom("Kadwa", size: 35).weight(.bold))
                Picker("Timespan", selection: $timeRange) {
                    ForEach(TimeRange.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .fixedSize()
                .padding()
//                Spacer()
                TableView(chooser: timeRange)
                Spacer()
            }
        }
    }
    
    
}

enum TimeRange: String, CaseIterable {
    case day = "Day"
    case week = "Week"
    case month = "Month"
}

struct TableView: View {
    var chooser: TimeRange
    
    var body: some View {
        switch chooser {
        case .day:
            DailyHabitView()
        case .week:
            WeeklyHabitView()
        case .month:
            MonthlyHeatmapView()
        }
    }
}

struct DailyHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allHabits: [AllHabits]

    @State private var didSeed = false
    @State private var showingAdd = false
    @State private var newHabitName = ""

    var body: some View {
        VStack(spacing: 12) {
            ProgressBar(percentage: percentage)

            if let container = allHabits.first {
                let habits = container.habits.sorted { ($0.order) < ($1.order) }

                List {
                    ForEach(habits, id: \.id) { habit in
                        HStack {
                            Text(habit.habitName)
                            Spacer()
                            Button {
                                toggleToday(habit)
                            } label: {
                                Image(systemName: habit.isCompleted() ? "checkmark.circle.fill" : "circle")
                                    .font(.title2)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.vertical, 4)
                    }
                    .onMove { source, destination in
                        moveHabits(in: container, from: source, to: destination) }
                    .onDelete { offsets in
                        deleteHabits(container: container, sortedHabits: habits, offsets: offsets)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAdd = true
                } label: {
                    Image(systemName: "plus")
                }
            }

            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
        }
        .sheet(isPresented: $showingAdd) {
            addHabitSheet
        }
        .task { seedIfNeeded() }
    }

    private var percentage: Float {
        guard let container = allHabits.first else { return 0 }
        let total = container.habits.count
        guard total > 0 else { return 0 }
        let done = container.habits.filter { $0.isCompleted() }.count
        return Float(done) / Float(total)
    }
    
    private func moveHabits(in container: AllHabits, from source: IndexSet, to destination: Int) {
        // Start from the same order the List is showing
        var ordered = container.habits.sorted { ($0.order) < ($1.order) }

        // Apply the move to that displayed order
        ordered.move(fromOffsets: source, toOffset: destination)

        // Persist the new order
        for (index, habit) in ordered.enumerated() {
            habit.order = index
        }

        // No need to reorder container.habits itself; UI sorts by 'order'
        try? modelContext.save()
    }


    private func toggleToday(_ habit: Habit) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            if habit.isCompleted() { habit.markIncomplete() }
            else { habit.markCompleted() }
        }

        if let container = allHabits.first {
            updateDailySummary(for: Date(), container: container)
        }

        try? modelContext.save()
    }

    private func updateDailySummary(for date: Date, container: AllHabits) {
        let key = dayKeyInt(from: date)

        let total = container.habits.count
        let completed = container.habits.reduce(0) { acc, h in
            acc + (h.isCompleted(on: date) ? 1 : 0)
        }

        let descriptor = FetchDescriptor<DailySummary>(
            predicate: #Predicate { $0.dayKey == key }
        )

        if let existing = try? modelContext.fetch(descriptor).first {
            existing.completedCount = completed
            existing.totalCount = total
        } else {
            modelContext.insert(DailySummary(dayKey: key, completedCount: completed, totalCount: total))
        }
    }

    private func dayKeyInt(from date: Date, calendar: Calendar = .current) -> Int {
        let c = calendar.dateComponents([.year, .month, .day], from: date)
        return (c.year! * 10_000) + (c.month! * 100) + c.day!
    }


    private func deleteHabits(container: AllHabits, sortedHabits: [Habit], offsets: IndexSet) {
        // delete all selected habits first
        for index in offsets {
            let habit = sortedHabits[index]
            container.habits.removeAll { $0.id == habit.id }
            modelContext.delete(habit)
        }

        // reorder habits array
        let reordered = container.habits.sorted { ($0.order) < ($1.order) }
        for (i, h) in reordered.enumerated() {
            h.order = i
        }
        
        // update summary once after deletions
        updateDailySummary(for: Date(), container: container)

        do {
            try modelContext.save()
        } catch {
            print("Delete save failed:", error)
        }
    }


    private var addHabitSheet: some View {
        NavigationStack {
            Form {
                Section("New habit") {
                    TextField("Habit name", text: $newHabitName)
                }
            }
            .navigationTitle("Add Habit")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        newHabitName = ""
                        showingAdd = false
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        addHabit()
                    }
                    .disabled(newHabitName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func addHabit() {
        guard let container = allHabits.first else { return }
        let name = newHabitName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else { return }

        // prevent duplicates by name
        if container.habits.contains(where: { $0.habitName.caseInsensitiveCompare(name) == .orderedSame }) {
            return
        }

        let habit = Habit(habitName: name, order: container.habits.count)
        container.habits.append(habit)
        modelContext.insert(habit)

        updateDailySummary(for: Date(), container: container)

        do {
            try modelContext.save()
        } catch {
            print("Save failed:", error)
        }

        newHabitName = ""
        showingAdd = false
    }


    private func seedIfNeeded() {
        guard !didSeed else { return }
        didSeed = true
        if allHabits.isEmpty {
            modelContext.insert(AllHabits())
            try? modelContext.save()
        }
    }
}

struct WeeklyHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allHabits: [AllHabits]

    @State private var didSeed = false
    @State private var referenceDate: Date = Date()   // “this week”; later you can add prev/next buttons

    private let dotSize: CGFloat = 14
    private let dotSpacing: CGFloat = 8

    var body: some View {
        let calendar = Calendar.current
        let weekStart = startOfWeekMonday(for: referenceDate, calendar: calendar)

        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Week")
                    .font(.title3).bold()

                Spacer()

                Text(weekRangeText(weekStart: weekStart, calendar: calendar))
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }

            headerRow()

            if let container = allHabits.first {
                let habits = container.habits.sorted { ($0.order) < ($1.order) }

                if habits.isEmpty {
                    ContentUnavailableView("No habits yet", systemImage: "list.bullet")
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(habits, id: \.id) { habit in
                                habitRow(habit: habit, weekStart: weekStart, calendar: calendar)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .padding()
        .task { seedIfNeeded() }
    }

    private func headerRow() -> some View {
        HStack {
            Text("Habit")
                .font(.caption).bold()
                .foregroundStyle(.secondary)
                .frame(width: 140, alignment: .leading)

            HStack(spacing: dotSpacing) {
                ForEach(0..<7, id: \.self) { i in
                    Text(dayLetter(forOffset: i))
                        .font(.caption).bold()
                        .foregroundStyle(.secondary)
                        .frame(width: dotSize)
                }
            }

            Spacer()

            Text("Total")
                .font(.caption).bold()
                .foregroundStyle(.secondary)
                .frame(width: 40, alignment: .trailing)
        }
    }

    private func habitRow(habit: Habit, weekStart: Date, calendar: Calendar) -> some View {
        let total = weeklyTotal(habit: habit, weekStart: weekStart, calendar: calendar)

        return HStack {
            Text(habit.habitName)
                .lineLimit(1)
                .frame(width: 140, alignment: .leading)

            HStack(spacing: dotSpacing) {
                ForEach(0..<7, id: \.self) { offset in
                    let date = calendar.date(byAdding: .day, value: offset, to: weekStart)!
                    let done = habit.isCompleted(on: date)

                    Circle()
                        .frame(width: dotSize, height: dotSize)
                        .foregroundStyle(done ? Color(myColors().UCLABlue) : Color(myColors().AliceBlue))
                        .overlay(
                            Circle().stroke(.secondary.opacity(0.2), lineWidth: 1)
                        )
                        .accessibilityLabel("\(habit.habitName), \(date.formatted(date: .abbreviated, time: .omitted)), \(done ? "done" : "not done")")
                }
            }

            Spacer()

            Text("\(total)")
                .font(.callout).bold()
                .foregroundStyle(.secondary)
                .frame(width: 40, alignment: .trailing)
        }
    }

    // MARK: - Helpers

    private func weeklyTotal(habit: Habit, weekStart: Date, calendar: Calendar) -> Int {
        (0..<7).reduce(0) { acc, offset in
            let date = calendar.date(byAdding: .day, value: offset, to: weekStart)!
            return acc + (habit.isCompleted(on: date) ? 1 : 0)
        }
    }

    private func startOfWeekMonday(for date: Date, calendar: Calendar) -> Date {
        var cal = calendar
        cal.firstWeekday = 2 // Monday
        let comps = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return cal.date(from: comps)!
    }

    private func weekRangeText(weekStart: Date, calendar: Calendar) -> String {
        let end = calendar.date(byAdding: .day, value: 6, to: weekStart)!
        let startStr = weekStart.formatted(date: .abbreviated, time: .omitted)
        let endStr = end.formatted(date: .abbreviated, time: .omitted)
        return "\(startStr) – \(endStr)"
    }

    private func dayLetter(forOffset offset: Int) -> String {
        // Mon..Sun
        ["M","T","W","T","F","S","S"][offset]
    }

    private func seedIfNeeded() {
        guard !didSeed else { return }
        didSeed = true

        if allHabits.isEmpty {
            modelContext.insert(AllHabits())
            try? modelContext.save()
        }
    }
}

struct MonthlyHeatmapView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allHabits: [AllHabits]

    @State private var didSeed = false
    @State private var month: Date = Date()
    @State private var summaries: [DailySummary] = []

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 7)

    var body: some View {
        let calendar = Calendar.current
        let monthStart = startOfMonth(for: month, calendar: calendar)
        let days = daysInMonth(for: monthStart, calendar: calendar)
        let firstWeekdayIndex = calendar.component(.weekday, from: monthStart) - 1 // Sunday=0..Saturday=6
        let totalCells = firstWeekdayIndex + days

        // dayKey -> score
        let scoreByKey: [Int: Double] = Dictionary(
            uniqueKeysWithValues: summaries.map { ($0.dayKey, $0.score) }
        )

        VStack(alignment: .leading, spacing: 12) {
            header(monthStart: monthStart, calendar: calendar)
            weekdayHeader()

            if let container = allHabits.first, container.habits.count > 0 {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(0..<totalCells, id: \.self) { i in
                        if i < firstWeekdayIndex {
                            Color.clear.frame(height: 28)
                        } else {
                            let day = i - firstWeekdayIndex + 1
                            let date = calendar.date(byAdding: .day, value: day - 1, to: monthStart)!
                            let key = dayKeyInt(from: date, calendar: calendar)
                            let score = scoreByKey[key] ?? 0

                            HeatCell(day: day, score: score)
                                .accessibilityLabel("\(date.formatted(date: .abbreviated, time: .omitted)), \(Int(score * 100))%")
                        }
                    }
                }

                legend()
            } else if allHabits.first != nil {
                ContentUnavailableView("No habits yet", systemImage: "list.bullet")
            } else {
                ProgressView()
            }
        }
        .padding()
        .task { seedIfNeeded() }
        .task(id: monthStart) { fetchSummariesForMonth(monthStart: monthStart, calendar: calendar) }
    }

    // MARK: - Header

    private func header(monthStart: Date, calendar: Calendar) -> some View {
        HStack {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    month = calendar.date(byAdding: .month, value: -1, to: month)!
                }
            } label: {
                Image(systemName: "chevron.left")
            }

            Spacer()

            Text(monthStart.formatted(.dateTime.year().month()))
                .font(.title3).bold()

            Spacer()

            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    month = calendar.date(byAdding: .month, value: 1, to: month)!
                }
            } label: {
                Image(systemName: "chevron.right")
            }
        }
        .buttonStyle(.plain)
    }

    private func weekdayHeader() -> some View {
        let labels = ["S","M","T","W","T","F","S"]
        return HStack {
            ForEach(labels.indices, id: \.self) { i in
                Text(labels[i])
                    .font(.caption).bold()
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Legend

    private func legend() -> some View {
        ZStack() {
            HStack(spacing: 8) {
                Text("Less").font(.caption).foregroundStyle(.secondary)
                ForEach([0.0, 0.25, 0.5, 0.75, 1.0], id: \.self) { v in
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.white)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(.secondary, lineWidth: 1))
                }
                Text("More").font(.caption).foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.top, 6)
            HStack(spacing: 8) {
                Text("Less").font(.caption).foregroundStyle(.secondary)
                ForEach([0.0, 0.25, 0.5, 0.75, 1.0], id: \.self) { v in
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 18, height: 18)
                        .foregroundStyle(heatColor(score: v))
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(.secondary.opacity(0.15), lineWidth: 1))
                }
                Text("More").font(.caption).foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.top, 6)
        }
    }

    // MARK: - Fetch

    private func fetchSummariesForMonth(monthStart: Date, calendar: Calendar) {
        let nextMonthStart = calendar.date(byAdding: .month, value: 1, to: monthStart)!
        let lastDay = calendar.date(byAdding: .day, value: -1, to: nextMonthStart)!

        let startKey = dayKeyInt(from: monthStart, calendar: calendar)
        let endKey = dayKeyInt(from: lastDay, calendar: calendar)

        let descriptor = FetchDescriptor<DailySummary>(
            predicate: #Predicate { $0.dayKey >= startKey && $0.dayKey <= endKey },
            sortBy: [SortDescriptor(\.dayKey)]
        )

        do {
            summaries = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch DailySummary failed:", error)
            summaries = []
        }
    }

    // MARK: - Seeding

    private func seedIfNeeded() {
        guard !didSeed else { return }
        didSeed = true

        if allHabits.isEmpty {
            modelContext.insert(AllHabits())
            try? modelContext.save()
        }
    }
}


private struct HeatCell: View {
    let day: Int
    let score: Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.white)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.secondary, lineWidth: 1))
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(heatColor(score: score))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.secondary.opacity(0.15), lineWidth: 1))

            Text("\(day)")
                .font(.caption2)
                .foregroundStyle(score >= 0.6 ? .white : .black.opacity(0.85))
        }
        .frame(height: 28)
    }
}

private func heatColor(score: Double) -> Color {
    // Simple stepped intensity (easy to read)
    switch score {
    case 0: return Color(myColors().AliceBlue)
    case 0..<0.25: return Color(myColors().AliceBlue).opacity(0.9)
    case 0..<0.5: return Color(myColors().UCLABlue).opacity(0.35)
    case 0..<0.75: return Color(myColors().UCLABlue).opacity(0.6)
    case 0..<1: return
        Color(myColors().UCLABlue).opacity(0.85)
    default: return Color(myColors().UCLABlue)
    }
}

struct ProgressBar: View {
    let percentage: Float

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(Int(percentage * 100))% completed")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color(myColors().AliceBlue))
                        .frame(height: 10)

                    Capsule()
                        .fill(Color(myColors().UCLABlue))
                        .frame(
                            width: geo.size.width * CGFloat(percentage),
                            height: 10
                        )
                        .animation(.easeInOut(duration: 0.3), value: percentage)
                }
            }
            .frame(height: 10)
        }
        // 👇 match List row horizontal padding
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    TablePage()
//        .environment(ViewModel())
}
