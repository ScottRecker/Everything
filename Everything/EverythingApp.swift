//
//  EverythingApp.swift
//  Everything
//
//  Created by Scott Recker on 10/16/22.
//

import SwiftUI

@main
struct EverythingApp: App {
    @StateObject var dataAccessor = SimulatorDataAccess()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
