//
//  ContentView.swift
//  TestSDKFlutter
//
//  Created by Loc hv on 19/12/24.
//
//
//import SwiftUI
//import Flutter
//import CoreNFC


import SwiftUI
import Flutter

struct ContentView: View {
    @EnvironmentObject var flutterManager: FlutterManager

    var body: some View {
        VStack(spacing: 20) {
            Text("Đây là SwiftUI App")
                .padding()

            Button(action: {
                presentFlutterNfcView()
            }) {
                Text("Mở Flutter NFC")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }

    func presentFlutterNfcView() {
        // Lấy sẵn FlutterEngine
        let engine = flutterManager.engine

        // Tạo FlutterViewController
        let flutterVC = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        flutterVC.modalPresentationStyle = .fullScreen

        // Lấy windowScene và rootViewController
        if let windowScene = UIApplication.shared
                .connectedScenes
                .first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            rootVC.present(flutterVC, animated: true)
        }
    }
}

//struct ViewDidLoadModifier: ViewModifier {
//    @State private var viewDidLoad = false
//    let action: (() -> Void)?
//    
//    func body(content: Content) -> some View {
//        content
//            .onAppear {
//                if viewDidLoad == false {
//                    viewDidLoad = true
//                    action?()
//                }
//            }
//    }
//}
//
//extension View {
//    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
//        self.modifier(ViewDidLoadModifier(action: action))
//    }
//}
//
//struct ContentView: View {
//    // Flutter dependencies are passed in an EnvironmentObject.
//    @EnvironmentObject var flutterDependencies: FlutterDependencies
//    
//    @State var counter = 0
//    
//    @State var flutterMethodChannel : FlutterMethodChannel?
//    @State var viewDidLoad = false
//    
//    var body: some View {
//        VStack {
//            Text("Counter: \(counter)").font(.largeTitle)
//            Button(action: {
//                increaseCounter()
//            }) {
//                Text("Get NFC")
//                    .font(.headline)
//                    .padding()
//                    .background(Color.yellow)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }.padding(.vertical, 8)
//            
//            Button(action: {
//                showFlutter()
//            }) {
//                Text("Open Flutter View")
//                    .font(.headline)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }.padding(.vertical, 10)
//            
//        }.onViewDidLoad {
//            handleMethodChannel()
//        }
//    }
//    
//    func increaseCounter() {
//        self.counter+=1
//        
//        if NFCNDEFReaderSession.readingAvailable {
//            print("Thiết bị hỗ trợ NFC.")
//        } else {
//            print("Thiết bị không hỗ trợ NFC.")
//        }
//        submitCounter()
//    }
//    
//    func showFlutter() {
//        // Get RootViewController from window scene
//        guard
//            let windowScene = UIApplication.shared.connectedScenes
//                .first(where: { $0.activationState == .foregroundActive && $0 is UIWindowScene }) as? UIWindowScene,
//            let window = windowScene.windows.first(where: \.isKeyWindow),
//            let rootViewController = window.rootViewController
//        else { return }
//        
//        // Create a FlutterViewController from pre-warm FlutterEngine
//        let flutterViewController = FlutterViewController(
//            engine: flutterDependencies.flutterEngine,
//            nibName: nil,
//            bundle: nil)
//        flutterViewController.modalPresentationStyle = .overCurrentContext
//        flutterViewController.isViewOpaque = false
//        
//        rootViewController.present(flutterViewController, animated: true)
//    }
//    
//    func handleMethodChannel() {
//        flutterMethodChannel = FlutterMethodChannel(name: "CHANNEL_EASY_EKYC", binaryMessenger: flutterDependencies.flutterEngine.binaryMessenger)
//        flutterMethodChannel?.setMethodCallHandler({
//            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
//            switch(call.method) {
//            case "NFC":
//                counter += 1
//                submitCounter()
////            case "getCounter":
////                submitCounter()
//            default:
//                print("Unrecognized method: \(call.method)")
//            }
//        })
//    }
//    
//    func submitCounter() {
//        flutterMethodChannel?.invokeMethod("NFC", arguments: counter)
//    }
//    
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
