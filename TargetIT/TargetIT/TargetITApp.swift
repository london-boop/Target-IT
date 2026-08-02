//
//  TargetITApp.swift
//  TargetIT
//
//  Created by JOURNi Student on 7/23/26.
//

import SwiftUI
import SwiftData

@main
struct TargetITApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
