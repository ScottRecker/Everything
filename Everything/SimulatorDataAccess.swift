//
//  SimulatorDataAccess.swift
//  Everything
//
//  Created by Scott Recker on 10/16/22.
//

import Foundation

// Inspired by https://paul-samuels.com/blog/2022/10/12/easy-simulator-data-access/

class SimulatorDataAccess: ObservableObject {

    init() {
        setup()
    }

    func setup() {
    #if targetEnvironment(simulator)
        let environment = ProcessInfo.processInfo.environment
        if let rootFolder = environment["SIMULATOR_HOST_HOME"].map(URL.init(fileURLWithPath:))?.appendingPathComponent("Desktop/SimulatorData"),
           let simulatorHome = environment["HOME"].map(URL.init(fileURLWithPath:)),
           let simulatorVersion = environment["SIMULATOR_RUNTIME_VERSION"],
           let simulatorName = environment["SIMULATOR_DEVICE_NAME"],
           let productName = Bundle.main.infoDictionary?["CFBundleName"]
        {
            let symlink = rootFolder.appendingPathComponent("\(productName) \(simulatorName) (\(simulatorVersion))")

            let fileManager = FileManager.default
            try? fileManager.createDirectory(at: rootFolder, withIntermediateDirectories: true)
            try? fileManager.removeItem(at: symlink)
            try? fileManager.createSymbolicLink(at: symlink, withDestinationURL: simulatorHome)
        }
    #endif
    }
}
