//
//  DemoSDKIosApp.swift
//  DemoSDKIos
//
//  Created by Loc hv on 25/12/24.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant

//class FlutterDependencies: ObservableObject {
//    let flutterEngine = FlutterEngine(name: "flutter-engine")
//    init() {
//        flutterEngine.run()
//        GeneratedPluginRegistrant.register(with: self.flutterEngine)
//    }
//}
//
//@main
//struct DemoSDKIosApp: App {
//    @StateObject var flutterDependencies = FlutterDependencies()
//    
//    var body: some Scene {
//        WindowGroup {
//            ContentView().environmentObject(flutterDependencies)
//        }
//    }
//}

@main
struct MyIosNfcAppApp: App {
    // Khởi tạo FlutterManager (có FlutterEngine)
    @StateObject var flutterManager = FlutterManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(flutterManager)
        }
    }
}

