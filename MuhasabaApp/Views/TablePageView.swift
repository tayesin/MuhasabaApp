//
//  TablePage.swift
//  Al Mathurat
//
//  Created by Tahasin Rahman on 8/18/24.
//

import SwiftUI

struct TablePage: View {
//    @Environment(ViewModel.self) private var viewModel
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
                .padding()
                TableView(chooser: timeRange)
                Spacer()
            }
        }
    }
}

enum TimeRange: String, CaseIterable {
    case day = "Day"
    case week = "Week"
}

struct TableView: View {
    var chooser: TimeRange
    @State var perc: Float = 0.5
    
    var body: some View {
        switch chooser {
        case .day:
            DayView(percentage: $perc)
        case .week:
            WeekView()
        }
    }
}

struct DayView: View {
//    @Environment(ViewModel.self) private var viewModel
    @Binding var percentage: Float
    var body: some View {
//        ProgressView("Daily Completion", value: percentage)
        ProgressBar(percentage: $percentage)
    }
}

struct WeekView: View {
    var body: some View {
        Text("hi")
    }
}

struct ProgressBar: View {
    @Binding var percentage: Float
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .offset(x: geometry.size.width * 0.1)
                    .fill(.gray)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.05)
                Rectangle()
                    .fill(.blue)
                    .frame(width: geometry.size.width * CGFloat(percentage), height: geometry.size.height * 0.05)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    TablePage()
//        .environment(ViewModel())
}
