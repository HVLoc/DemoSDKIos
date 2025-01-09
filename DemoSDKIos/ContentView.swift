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
//                presentCCCDVerificationView(data: ["value": userInfo])
                openFlutterSDK() { result in
//                    userInfo = result
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

            Spacer()
        }
        .padding()
    }

    func openFlutterSDK( onReceiveData: @escaping ([String: Any]) -> Void) {
        
        let flutterVC = FlutterViewController(engine: FlutterManager.shared.engine, nibName: nil, bundle: nil)
        flutterVC.modalPresentationStyle = .fullScreen

        // Thiết lập MethodChannel để nhận dữ liệu từ Flutter
        let methodChannel = FlutterMethodChannel(name: "2id.ekyc", binaryMessenger: flutterVC.binaryMessenger)
        methodChannel.setMethodCallHandler { call, result in
            if call.method == "dataUser" {
                if let args = call.arguments as? [String: Any],
                      let value = args["value"] as? [String: Any] {
                       print("Received data: \(value)")
                    // Ẩn Flutter View Controller trước
                               flutterVC.dismiss(animated: true) {
                                   // Sau khi dismiss, trình bày màn hình mới
                                   DispatchQueue.main.async {
                                       presentCCCDVerificationView(data: value)
                                   }
                               }
//                        onReceiveData(value)
//                       // Chuyển đổi `value` thành đối tượng hoặc sử dụng trực tiếp
//                    presentCCCDVerificationView(data: value)
                   } else {
                       print("Invalid arguments")
                   }
//                flutterVC.dismiss(animated: true, completion: nil)
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
