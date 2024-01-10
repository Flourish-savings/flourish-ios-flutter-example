import SwiftUI
import Flutter
import FlutterPluginRegistrant

class FlutterDependencies: ObservableObject {
  let flutterEngine = FlutterEngine(name: "flourish")
  init(){
    flutterEngine.run()
    GeneratedPluginRegistrant.register(with: self.flutterEngine);
  }
}

@main
struct flourish_ios_flutter_exampleApp: App {
    @StateObject var flutterDependencies = FlutterDependencies()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(flutterDependencies)
        }
    }
}
