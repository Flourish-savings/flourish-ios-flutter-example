import SwiftUI
import Flutter

struct OnBoardingView: View {
    
    @EnvironmentObject var flutterEngine: FlutterEngineWrapper
    @State private var showFlutterView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 20)
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    .padding(.top, 5)
                
                Spacer()
                
                NavigationLink(
                    destination: FlutterViewControllerWrapper().environmentObject(flutterEngine),
                    label: {
                        Text("Next")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct FlutterViewControllerWrapper: UIViewControllerRepresentable {
    @EnvironmentObject var flutterEngine: FlutterEngineWrapper

    func makeUIViewController(context: Context) -> FlutterViewController {
        let flutterViewController = FlutterViewController(engine: flutterEngine.engine, nibName: nil, bundle: nil)
        let methodChannel = FlutterMethodChannel(name: "flourish",
                                                 binaryMessenger: flutterViewController.binaryMessenger)

        methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "onBackButtonPressedEvent" {
                if let message = call.arguments as? String {
                    receiveMessageFromFlutter(message)
                    result("Message received on iOS")
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Message not provided", details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return flutterViewController
    }

    func updateUIViewController(_ uiViewController: FlutterViewController, context: Context) {}

    private func receiveMessageFromFlutter(_ message: String) {
        print("Received message from Flutter: \(message)")
    }

    private func sendMessageToFlutter(_ message: String) {
        let methodChannel = FlutterMethodChannel(name: "com.example.flutter/native",
                                                 binaryMessenger: flutterEngine.engine.binaryMessenger)
        methodChannel.invokeMethod("receiveMessage", arguments: message)
    }
}



#Preview {
    OnBoardView()
}
