//
//  FlutterManager.swift
//  DemoSDKIos
//
//  Created by Loc hv on 25/12/24.
//

//import Flutter
//import Foundation
//import FlutterPluginRegistrant
//
//class FlutterManager: ObservableObject {
//    static let shared = FlutterManager()
//    let engine: FlutterEngine
//
//    private init() {
//        self.engine = FlutterEngine(name: "flutter_engine")
//        self.engine.run()
//        GeneratedPluginRegistrant.register(with: self.engine)
//        
//    }
//
//}

import Flutter
import FlutterPluginRegistrant

class FlutterManager {
    static let shared = FlutterManager()

    func createNewEngine() -> FlutterEngine {
        let flutterEngine = FlutterEngine(name: "flutter_engine_\(UUID().uuidString)")
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: flutterEngine)
        return flutterEngine
    }
}
