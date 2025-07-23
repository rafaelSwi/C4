//
//  C4App.swift
//  C4
//
//  Created by Xbox Mil Grau on 22/07/25.
//

import SwiftUI

import SwiftUI

@main
struct C4App: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            FrontEndView(viewModel: appDelegate.viewModel)
        }
        .defaultSize(CGSize(width: 400, height: 400))
        
    }
}
