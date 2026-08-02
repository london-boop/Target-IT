//
//  AppRootShellView.swift
//  TargetIT
//
//  Wraps the main shell in a shared local app data store.
//

import SwiftUI

struct AppRootShellView: View {
    @StateObject private var appDataStore = AppDataStore()

    var body: some View {
        MainTabView()
            .environmentObject(appDataStore)
    }
}

#Preview {
    AppRootShellView()
}
