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

        let flutterEngine = FlutterManager.shared.engine
        let flutterVC = FlutterViewController(
            engine: flutterEngine, nibName: nil, bundle: nil)
        flutterVC.modalPresentationStyle = .fullScreen

        // Thiết lập MethodChannel và lưu trữ tham chiếu
        let methodChannel = FlutterMethodChannel(
            name: "2id.ekyc",
            binaryMessenger: flutterEngine.binaryMessenger)

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
            } else if call.method == "setInitial" {
                // Khai báo dữ liệu dưới dạng Dictionary
                let jsonPayload: [String: Any] = [
                    "key": "89f797ab-ec41-446a-8dc1-1dfda5e7e93d",  // Cung cấp bởi 2id
                    "secretKey": "63f81c69722acaa42f622ec16d702fdb",  // Cung cấp bởi 2id
                    "isProd": false,  // Biến xác định hệ thống demo/prod
                    "CCCD": "027998007724",  // Truyền vào giá trị Căn cước vào để thực hiện xác thực luôn, nếu không truyền thì sử dụng quét QR
                ]
                if let jsonData = try? JSONSerialization.data(
                    withJSONObject: jsonPayload),
                    let jsonString = String(data: jsonData, encoding: .utf8)
                {
                    result(jsonString)
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
        let flutterEngine = FlutterManager.shared.engine
        let flutterVC = FlutterViewController(
            engine: flutterEngine, nibName: nil, bundle: nil)
        flutterVC.modalPresentationStyle = .fullScreen

        // Thiết lập MethodChannel và lưu trữ tham chiếu
        let methodChannel = FlutterMethodChannel(
            name: "2id.ekyc",
            binaryMessenger: flutterVC.binaryMessenger)

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
            } else if call.method == "setInitialNFC" {
                // Chỉ đọc NFC

                result("Success NFC")
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
