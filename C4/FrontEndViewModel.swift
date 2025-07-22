//
//  FrontEndViewModel.swift
//  C4
//
//  Created by Rafael Neuwirth Swierczynski on 22/07/25.
//

import Foundation
import SwiftUI

class FrontEndViewModel: ObservableObject {
    @Published var inputMinutes: String = "0"
    @Published var inputHours: String = "0"
    @Published var inputSeconds: String = "0"
    @Published var remainingTimeFormatted: String?
    
    
    private var manager = MacControlManager()
    private var timer: Timer?
    
    func startTimer() {
        guard let h = Int(inputHours), let m = Int(inputMinutes), let s = Int(inputSeconds) else {
            return
        }
        
        let totalSeconds = (h * 3600) + (m * 60) + s
        guard totalSeconds > 0 else {
            return
        }
        
        manager.startTimer(durationInSeconds: totalSeconds)
        startCountdown(seconds: totalSeconds)
    }
    
    func clear() {
        inputHours = "0"
        inputMinutes = "0"
        inputSeconds = "0"
    }
    
    func cancelTimer() {
        manager.cancelTimer()
        timer?.invalidate()
        timer = nil
        remainingTimeFormatted = nil
    }
    
    
    private func startCountdown(seconds: Int) {
        var remaining = seconds
        remainingTimeFormatted = formatTime(seconds: Double(remaining))
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            remaining -= 1
            if remaining <= 0 {
                self.remainingTimeFormatted = nil
                self.timer?.invalidate()
                return
            }
            self.remainingTimeFormatted = self.formatTime(seconds: Double(remaining))
        }
        
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    private func formatTime(seconds: Double) -> String {
        let totalMilliseconds = Int(seconds * 1000)
        
        let hours = totalMilliseconds / 3_600_000
        let minutes = (totalMilliseconds % 3_600_000) / 60_000
        let secs = (totalMilliseconds % 60_000) / 1000
        
        return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    }
}
