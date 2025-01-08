//
//  FlutterManager.swift
//  DemoSDKIos
//
//  Created by Loc hv on 25/12/24.
//

import Flutter
import Foundation
import FlutterPluginRegistrant

class FlutterManager: ObservableObject {
    static let shared = FlutterManager()
    let engine: FlutterEngine

    private init() {
        self.engine = FlutterEngine(name: "flutter_engine")
        self.engine.run()
        GeneratedPluginRegistrant.register(with: self.engine)
        
    }

}
