//
//  FastingHeader.swift
//  FastFast
//
//  Created by David Moreen on 12/6/23.
//

import SwiftUI

struct CompletedFast {
    let startDate: Date
    let endDate: Date
    let selectedLengthHours: Int
}

struct FastingTimer: View {
    let fastEnded: (Fast) -> Void

    @State private var selectedFastLength: Int = DateUtil.FOUR_HOURS_IN_SECONDS
    @State private var startDate: Date?
    @State private var progress = 0.0
    private let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()

    private var elapsedTimeString: String? {
        guard let startDate else { return nil }
        return DateUtil.elapsedString(start: startDate)
    }

    private func startAction() {
        startDate = Date()
    }

    private func endAction() {
        guard let startDate else { return }
        fastEnded(.init(
            startDate: startDate,
            selectedFastLength: selectedFastLength,
            endDate: Date())
        )
        self.startDate = nil
        self.progress = 0
    }

    private func updateProgress() {
        guard let startDate else { return }
        let timeSinceNow = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
        let progress = timeSinceNow / Double(selectedFastLength)

        guard progress < 1 else {
            self.endAction()
            return
        }
        self.progress = progress
    }

    private var isFasting: Bool {
        startDate != nil
    }

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                circleProgressBackgroundView
                circleProgressView
                elapsedTime
            }
            .padding(.horizontal)
            .padding(.bottom, 15)

            Picker("Fast Length", selection: $selectedFastLength) {
                Text("5 Seconds").tag(DateUtil.FIVE_SECONDS)
                Text("4 hours").tag(DateUtil.FOUR_HOURS_IN_SECONDS)
                Text("8 hours").tag(DateUtil.EIGHT_HOURS_IN_SECONDS)
                Text("12 hours").tag(DateUtil.TWELVE_HOURS_IN_SECONDS)
                Text("24 hours").tag(DateUtil.TWENTYFOUR_HOURS_IN_SECONDS)
            }
            .pickerStyle(.automatic)
            .disabled(isFasting)

            Button(action: isFasting ? endAction : startAction) {
                Group {
                    Spacer()
                    if isFasting {
                        Text("End Fast")
                    } else {
                        Text("Start Fast")
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
                .font(.title3)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(35)
            .tint(isFasting ? Color.red : Color.blue)
        }
        .padding()
        .onReceive(timer, perform: { _ in
            withAnimation {
                self.updateProgress()
            }
        })
    }

    private var elapsedTime: some View {
        Group {
            if let elapsedTimeString {
                Text(elapsedTimeString)
            } else {
                Text("Press Start")
            }
        }
        .font(.largeTitle)
    }

    private var circleProgressView: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(
                Color.green,
                style: .init(
                    lineWidth: 30,
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(-90))
    }

    private var circleProgressBackgroundView: some View {
        Circle()
            .stroke(
                Color.green.opacity(0.1),
                lineWidth: 30
            )
    }
}

#Preview {
    FastingTimer(fastEnded: {_ in})
}
