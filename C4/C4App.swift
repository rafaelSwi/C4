//
//  C4App.swift
//  C4
//
//  Created by Rafael Neuwirth Swierczynski on 22/07/25.
//

import SwiftUI

@main
struct C4App: App {
    var body: some Scene {
        WindowGroup {
            FrontEndView()
        }
        .defaultSize(CGSize(width: 400, height: 400))
        
    }
}
