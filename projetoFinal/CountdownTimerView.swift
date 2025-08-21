//
//  CountdownTimerView.swift
//  projetoFinal
//
//  Created by found on 21/08/25.
//

import SwiftUI

@MainActor
class CountdownTimerViewModel: ObservableObject {
    @Published var day: Int = 0
    @Published var hour: Int = 0
    @Published var minute: Int = 0
    @Published var second: Int = 0

    private(set) var endDate: Date

    var hasCountdownCompleted: Bool {
        Date() > endDate
    }

    init(endDate: String) {
        self.endDate = Self.parseDate(endDate)
        updateTimer()
    }

    func updateTimer() {
        let calendar = Calendar(identifier: .gregorian)
        let now = Date()
        let timeValue = calendar.dateComponents([.day, .hour, .minute, .second], from: now, to: endDate)

        if !hasCountdownCompleted,
           let day = timeValue.day,
           let hour = timeValue.hour,
           let minute = timeValue.minute,
           let second = timeValue.second {
            self.day = day
            self.hour = hour
            self.minute = minute
            self.second = second
        } else {
            // Countdown finished
            self.day = 0
            self.hour = 0
            self.minute = 0
            self.second = 0
        }
    }


    private static func parseDate(_ dateString: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: dateString) ?? Date()
    }
}

struct CountdownTimerView: View {
    @StateObject private var viewModel: CountdownTimerViewModel
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var hasCountdownCompleted: Bool {
        viewModel.hasCountdownCompleted
    }

    init(endDate: String) {
        _viewModel = StateObject(wrappedValue: CountdownTimerViewModel(endDate: endDate))
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                timeUnitView(value: viewModel.day, label: "dias")
                colon
                timeUnitView(value: viewModel.hour, label: "horas")
                colon
                timeUnitView(value: viewModel.minute, label: "min")
                colon
                timeUnitView(value: viewModel.second, label: "seg")
            }
        }
        .onReceive(timer) { _ in
            if hasCountdownCompleted {
                timer.upstream.connect().cancel()
            } else {
                viewModel.updateTimer()
            }
        }
    }

    private func timeUnitView(value: Int, label: String) -> some View {
        VStack(spacing: 4) {
            Text(String(format: "%02d", value))
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.red)
            Text(label.uppercased())
                .font(.system(size: 11))
        }
    }

    private var colon: some View {
        Text(":")
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.red)
    }
}

#Preview {
    CountdownTimerView(endDate: "2025-12-05T00:00:00Z")
}
