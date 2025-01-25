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
        VStack(/*alignment: .leading, spacing: 7*/) {
            HStack {
                Text("\(Int(percentage * 100))% completed").bold().font(.callout)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .leading, endPoint: .trailing))
                    .padding(.leading, 50)
                Spacer()
            }
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 300, height: 12)
                    .foregroundStyle(Color(myColors().AliceBlue))
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 300 * CGFloat(percentage), height: 12, alignment: .center)
                    .foregroundStyle(Color(myColors().UCLABlue))
            }
        }
        .padding(20)
        .background(.white, in: .rect(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 20, x: 0.0, y: 0.0)
    }
}

#Preview {
    TablePage()
//        .environment(ViewModel())
}
