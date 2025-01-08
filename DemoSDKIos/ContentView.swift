//
//  ContentView.swift
//  TestSDKFlutter
//
//  Created by Loc hv on 19/12/24.
//
//

import SwiftUI
import Flutter

struct ContentView: View {
    @State private var userInfo: String = "No Data"
    @State private var showFlutterSDK = false

    var body: some View {
        VStack {
            Text("User Info:")
            Text(userInfo)

            Spacer()

            Button(action: {
                let payload: [String: Any] = [
                    "key": "89f797ab-ec41-446a-8dc1-1dfda5e7e93d",
                    "secretKey": "63f81c69722acaa42f622ec16d702fdb",
                    "CCCD": "020098007724"
                ]
                openFlutterSDK(payload: payload) { result in
                    userInfo = result
                }
            }) {
                Text("Launch Flutter SDK")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
    }

    func openFlutterSDK(payload: [String: Any], onReceiveData: @escaping (String) -> Void) {
        
        let flutterVC = FlutterViewController(engine: FlutterManager.shared.engine, nibName: nil, bundle: nil)
        flutterVC.modalPresentationStyle = .fullScreen

        // Thiết lập MethodChannel để nhận dữ liệu từ Flutter
        let methodChannel = FlutterMethodChannel(name: "2id.ekyc", binaryMessenger: flutterVC.binaryMessenger)
        methodChannel.setMethodCallHandler { call, result in
            if call.method == "dataUser" {
                if let args = call.arguments as? String {
                    onReceiveData(args)
                }
                flutterVC.dismiss(animated: true, completion: nil)
                result("Data received")
            }
            else if call.method == "setInitial" {
                
                let payload: [String: Any] = [
                    "key": "89f797ab-ec41-446a-8dc1-1dfda5e7e93d",
                    "secretKey": "63f81c69722acaa42f622ec16d702fdb",
                    "CCCD": "020098007724"
                ]
                
                if let jsonData = try? JSONSerialization.data(withJSONObject: payload),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    result(jsonString)
                }
                result("Data received")
            }
            
            else {
                result(FlutterMethodNotImplemented)
            }
        }

        // Hiển thị Flutter SDK
        if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            rootVC.present(flutterVC, animated: true)
        }
    }
}
