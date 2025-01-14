//
//  ContentView.swift
//  TestSDKFlutter
//
//  Created by Loc hv on 19/12/24.
//
//

import Flutter
import SwiftUI

struct ContentView: View {
    @State private var userInfo: String = "No Data"
    @State private var showFlutterSDK = false
    
    var body: some View {
        VStack {
            Text("User Info:")
            Text(userInfo)
            
            Spacer()
            
            Button(action: {
                openFlutterSDK { result in
                    presentCCCDVerificationView(data: result)
                }
            }) {
                Text("Launch Flutter SDK")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button(action: {
                openFlutterSDKNFC()
            }) {
                Text("Launch Flutter SDK NFC")
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
    
    func openFlutterSDK(onReceiveData: @escaping ([String: Any]) -> Void) {
        
        // Tạo một tiến trình Flutter mới
        let flutterEngine = FlutterManager.shared.createNewEngine()
        let flutterVC = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterVC.modalPresentationStyle = .fullScreen
        
        // Tạo MethodChannel
        let methodChannel = FlutterMethodChannel(
            name: "2id.ekyc",
            binaryMessenger: flutterEngine.binaryMessenger
        )
        
        // Khai báo dữ liệu dưới dạng Dictionary
        let jsonPayload: [String: Any] = [
            "key": "89f797ab-ec41-446a-8dc1-1dfda5e7e93d",  // Cung cấp bởi 2id
            "secretKey": "63f81c69722acaa42f622ec16d702fdb",  // Cung cấp bởi 2id
            "isProd": false,  // Biến xác định hệ thống demo/prod
            //            "CCCD": "027998007724",  // Truyền vào giá trị Căn cước vào để thực hiện xác thực luôn, nếu không truyền thì sử dụng quét QR
        ]
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: jsonPayload)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            
            // Gửi dữ liệu qua MethodChannel
            methodChannel.invokeMethod("setInitial", arguments: jsonString) { result in
                if let response = result as? String {
                    print("Response from Flutter: \(response)")
                }
            }
            
        } catch {
            print("Failed to encode JSON: \(error)")
        }
        methodChannel.setMethodCallHandler { [weak flutterVC] call, result in
            if call.method == "dataUser" {
                if let args = call.arguments as? [String: Any],
                   let value = args["value"] as? [String: Any]
                {
                    flutterVC?.dismiss(animated: true) {
                        DispatchQueue.main.async {
                            onReceiveData(value)
                        }
                    }
                } else {
                    print("Invalid arguments")
                }
                result("Data received")
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        // Hiển thị Flutter SDK
        if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            rootVC.present(flutterVC, animated: true)
        }
    }
    
    func openFlutterSDKNFC() {
        // Tạo một tiến trình Flutter mới
        let flutterEngine = FlutterManager.shared.createNewEngine()
        let flutterVC = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterVC.modalPresentationStyle = .fullScreen
        
        // Tạo MethodChannel
        let methodChannel = FlutterMethodChannel(
            name: "2id.ekyc",
            binaryMessenger: flutterEngine.binaryMessenger
        )
        
        // Gửi dữ liệu qua MethodChannel
        methodChannel.invokeMethod("setInitialNFC", arguments: ["key": "Hello from iOS"]) { result in
            if let response = result as? String {
                print("Response from Flutter: \(response)")
            }
        }
        methodChannel.setMethodCallHandler { [weak flutterVC] call, result in
            if call.method == "dataNFC" {
                if let args = call.arguments as? [String: Any],
                   let value = args["value"] as? [String: Any]
                {
                    print(value)
                    flutterVC?.dismiss(animated: true)
                } else {
                    print("Invalid arguments")
                }
                result("Data received")
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        // Hiển thị Flutter SDK
        if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            rootVC.present(flutterVC, animated: true)
        }
    }
    
}
