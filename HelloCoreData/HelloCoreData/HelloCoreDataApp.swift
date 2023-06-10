//
//  HelloCoreDataApp.swift
//  HelloCoreData
//
//  Created by william torres dias dos santos on 16/12/22.
//

import SwiftUI

@main
struct HelloCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
           ContentView(coreDM: CoreDataManager())
        }
    }
}
