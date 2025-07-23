//
//  AppDelegate.swift
//  C4
//
//  Created by Rafael Neuwirth Swierczynski on 22/07/25.
//

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    let touchBarController = TouchBarController()
    let viewModel = FrontEndViewModel()
    var timerWindow: NSWindow?
    var timerLabel: NSTextField?

    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ notification: Notification) {
        touchBarController.viewModel = viewModel

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let window = NSApplication.shared.windows.first {
                window.makeKeyAndOrderFront(nil)
                window.title = "Timer"
                window.touchBar = self.touchBarController.makeTouchBar()
            }
        }

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.title = viewModel.remainingTimeFormatted ?? "--:--:--"
            button.action = #selector(self.menuBarClicked)
            button.target = self
        }

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let time = self.viewModel.remainingTimeFormatted ?? "--:--:--"
            self.touchBarController.updateTime(time)
            self.statusItem.button?.title = time
        }
    }

    @objc func menuBarClicked() {
        // nothing
    }
}
