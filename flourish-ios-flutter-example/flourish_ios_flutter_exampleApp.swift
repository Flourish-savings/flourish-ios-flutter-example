import SwiftUI
import Flutter
import FlutterPluginRegistrant

class FlutterEngineWrapper: ObservableObject {
  let engine = FlutterEngine(name: "flourish")
    
    init(){
        engine.run()
        GeneratedPluginRegistrant.register(with: self.engine);
    }
    
    func initializeFlutter() {
        let flutterViewController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        let methodChannel = FlutterMethodChannel(name: "flourish", binaryMessenger: flutterViewController.binaryMessenger)

        var jsonObject: [String: Any] = [:]

        do {
            jsonObject["partnerId"] = ProcessInfo.processInfo.environment["PARTNER_ID"]
            jsonObject["secret"] = ProcessInfo.processInfo.environment["PARTNER_SECRET"]
            jsonObject["env"] = ProcessInfo.processInfo.environment["ENVIRONMENT"]
            jsonObject["language"] = ProcessInfo.processInfo.environment["LANGUAGE"]
            jsonObject["customerCode"] = ProcessInfo.processInfo.environment["CUSTOMER_CODE"]

            let yourArgumentsData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])

            if let yourArguments = String(data: yourArgumentsData, encoding: .utf8) {
                print(yourArguments)

                methodChannel.invokeMethod("initialize", arguments: yourArguments)
            }
        } catch {
            print("Error serializing JSON: \(error.localizedDescription)")
        }
    }
}

class FlutterEngineCampaignWrapper: ObservableObject {
  let engineCampaign = FlutterEngine(name: "flourish")
    
    init(){
        engineCampaign.run()
        GeneratedPluginRegistrant.register(with: self.engineCampaign);
    }
    
    func initializeFlutter() {
        let flutterViewController = FlutterViewController(engine: engineCampaign, nibName: nil, bundle: nil)
        let methodChannel = FlutterMethodChannel(name: "flourish", binaryMessenger: flutterViewController.binaryMessenger)

        var jsonObject: [String: Any] = [:]

        do {
            jsonObject["partnerId"] = ProcessInfo.processInfo.environment["PARTNER_ID_CAMPAIGN"]
            jsonObject["secret"] = ProcessInfo.processInfo.environment["PARTNER_SECRET_CAMPAIGN"]
            jsonObject["env"] = ProcessInfo.processInfo.environment["ENVIRONMENT_CAMPAIGN"]
            jsonObject["language"] = ProcessInfo.processInfo.environment["LANGUAGE_CAMPAIGN"]
            jsonObject["customerCode"] = ProcessInfo.processInfo.environment["CUSTOMER_CODE_CAMPAIGN"]

            let yourArgumentsData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])

            if let yourArguments = String(data: yourArgumentsData, encoding: .utf8) {
                print(yourArguments)

                methodChannel.invokeMethod("initialize", arguments: yourArguments)
            }
        } catch {
            print("Error serializing JSON: \(error.localizedDescription)")
        }
    }
}

@main
struct flourish_ios_flutter_exampleApp: App {
    @StateObject var flutterEngine = FlutterEngineWrapper()
    @StateObject var flutterEngineCampaign = FlutterEngineCampaignWrapper()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(flutterEngine)
                .environmentObject(flutterEngineCampaign)
                .onAppear {
                    flutterEngine.initializeFlutter()
                    flutterEngineCampaign.initializeFlutter()
                }
        }
    }
}
