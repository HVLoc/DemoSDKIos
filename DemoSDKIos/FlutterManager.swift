//
//  FlutterManager.swift
//  DemoSDKIos
//
//  Created by Loc hv on 25/12/24.
//

import Flutter
import Foundation
import FlutterPluginRegistrant


/// Lớp này giữ FlutterEngine để có thể tái sử dụng.
class FlutterManager: ObservableObject {
    static let shared = FlutterManager()

    let engine: FlutterEngine

    private init() {
        engine = FlutterEngine(name: "flutter_nfc_engine")
        engine.run()
        // Đăng ký plugin (nếu cần)
        GeneratedPluginRegistrant.register(with: engine)
    }
}

//class FlutterDependencies: ObservableObject {
//    let flutterEngine = FlutterEngine(name: "flutter-engine")
//    init() {
//        flutterEngine.run()
//        GeneratedPluginRegistrant.register(with: self.flutterEngine)
//    }
//}
