//
//  _0210526_BornaLibertines_NYCSchoolsApp.swift
//  Shared
//
//  Created by Borna Libertines on 5/26/21.
//

import SwiftUI

@main
struct _0210526_BornaLibertines_NYCSchoolsApp: App {
    @StateObject private var schools = SchoolViewModel()
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(schools)
        }.onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                debugPrint("App is active")
            case .inactive:
                debugPrint("App is inactive")
            case .background:
                debugPrint("App is in background")
            
            @unknown default:
                debugPrint("Oh - interesting: I received an unexpected new value.")
            }
          }
    }
}
