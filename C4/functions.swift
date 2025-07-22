//
//  functions.swift
//  C4
//
//  Created by Rafael Neuwirth Swierczynski on 22/07/25.
//

import Foundation
import AppKit

class MacControlManager {
    
    private var timer: Timer?
    private var remainingTime: TimeInterval = 0

    func startTimer(durationInSeconds: Int) {
        cancelTimer()

        self.remainingTime = TimeInterval(durationInSeconds)

        print("Timer iniciado para \(durationInSeconds) segundos.")

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }

    func cancelTimer() {
        timer?.invalidate()
        timer = nil
        remainingTime = 0
        print("Timer cancelado.")
    }

    @objc private func updateTimer() {
        remainingTime -= 1
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        print(String(format: "Tempo restante: %02d:%02d", minutes, seconds))

        if remainingTime <= 0 {
            timer?.invalidate()
            timer = nil
            performAction()
        }
    }

    private func performAction() {
        let task = Process()
        task.launchPath = "/usr/bin/pmset"
        task.arguments = ["sleepnow"]
        task.launch()
    }
}
