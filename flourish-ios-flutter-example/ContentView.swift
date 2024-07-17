import SwiftUI
import Flutter

struct ContentView: View {
    @EnvironmentObject var flutterEngine: FlutterEngineWrapper
    @EnvironmentObject var flutterEngineCampaign: FlutterEngineCampaignWrapper
    
    @State private var showFlutterView = false
    
    var body: some View {
        NavigationView {
            VStack {

                NavigationLink(
                    destination: FlutterViewControllerWrapper().environmentObject(flutterEngine),
                    label: {
                        Text("Go to Referral")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                .padding(.horizontal)
                
                Spacer().frame(height: 20)
                
                NavigationLink(
                    destination: OnBoardingView(),
                    label: {
                        Text("Go to Referral after OnBoarding")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                .padding(.horizontal)
                
                Spacer().frame(height: 20)
                
                NavigationLink(
                    destination: FlutterViewControllerCampaingWrapper().environmentObject(flutterEngineCampaign),
                    label: {
                        Text("Go to Campaign")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                .padding(.horizontal)
            }
            
            .padding()
            .navigationTitle("FlourishApp")
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
    }
    
    struct FlutterViewControllerCampaingWrapper: UIViewControllerRepresentable {
        @EnvironmentObject var flutterEngineCampaign: FlutterEngineCampaignWrapper

        func makeUIViewController(context: Context) -> FlutterViewController {
            let flutterViewController = FlutterViewController(engine: flutterEngineCampaign.engineCampaign, nibName: nil, bundle: nil)
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
    }
}

#Preview {
    OnBoardView()
}
