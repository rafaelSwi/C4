//
//  TouchBarController.swift
//  C4
//
//  Created by Xbox Mil Grau on 22/07/25.
//

import AppKit

extension NSTouchBarItem.Identifier {
    static let timerLabel = NSTouchBarItem.Identifier("Xbox Mil Grau.C4.timerLabel")
}

class TouchBarController: NSObject, NSTouchBarDelegate {
    var viewModel: FrontEndViewModel?

    private enum TouchBarItemIdentifiers {
        static let timerLabel = NSTouchBarItem.Identifier("Xbox Mil Grau.timerLabel")
        static let startButton = NSTouchBarItem.Identifier("Xbox Mil Grau.startButton")
        static let cancelButton = NSTouchBarItem.Identifier("Xbox Mil Grau.cancelButton")
        
    }

    func makeTouchBar() -> NSTouchBar {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.defaultItemIdentifiers = [.fixedSpaceSmall, TouchBarItemIdentifiers.timerLabel, .flexibleSpace, TouchBarItemIdentifiers.startButton, TouchBarItemIdentifiers.cancelButton]
        return touchBar
    }

    func updateTime(_ text: String) {
        if let item = NSApplication.shared.windows.first?.touchBar?.item(forIdentifier: TouchBarItemIdentifiers.timerLabel) as? NSCustomTouchBarItem,
           let label = item.view as? NSTextField {
            label.stringValue = text
        }
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case TouchBarItemIdentifiers.timerLabel:
            let item = NSCustomTouchBarItem(identifier: identifier)
            let label = NSTextField(labelWithString: viewModel?.remainingTimeFormatted ?? "--:--:--")
            label.alignment = .center
            label.font = NSFont.monospacedDigitSystemFont(ofSize: 16, weight: .medium)
            label.textColor = .systemGreen
            item.view = label
            return item

        case TouchBarItemIdentifiers.startButton:
            if (viewModel?.remainingTimeFormatted != nil) {
                return nil;
            }
            let item = NSCustomTouchBarItem(identifier: identifier)
            item.view = NSButton(title: String(localized: "touchBarStart"), target: self, action: #selector(startAction))
            return item

        case TouchBarItemIdentifiers.cancelButton:
            let item = NSCustomTouchBarItem(identifier: identifier)
            item.view = NSButton(title: String(localized: "touchBarCancel"), target: self, action: #selector(cancelAction))
            return item

        default:
            return nil
        }
    }

    @objc private func startAction() {
        viewModel?.startTimer()
    }

    @objc private func cancelAction() {
        viewModel?.cancelTimer()
    }
}
