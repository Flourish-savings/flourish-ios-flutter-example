[<img width="400" src="https://github.com/Flourish-savings/flourish-sdk-flutter/blob/main/images/logo_flourish.png?raw=true"/>](https://flourishfi.com)
<br>
<br>
# Flourish iOS Flutter example

This project is an example of how to integrate a native iOS application with our Flutter module
<br>

# Getting Started
___
## Configuration
### Embed the Flutter module in your existing application

Our Flutter module can be incrementally added to your iOS app as embedded frameworks.

#### Embed with CocoaPods and the Flutter SDK

This method requires that your project has a locally installed version of the Flutter SDK.

##### Download our Flutter module project here:
https://github.com/Flourish-savings/flourish-sdk-module-flutter

This step is important, you will need to save this Flutter module in the same directory as your native iOS App


```sh
some/path/
├── flourish_flutter_module/
│   └── .ios/
│       └── Flutter/
│         └── podhelper.rb
└── YourApp/
    └── Podfile
```

##### Add the following lines to your Podfile:
The next step is adding the dependencies to build.gradle

YourApp/Podfile
```sh
flutter_application_path = '../flourish_flutter_module'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
```

##### For each Podfile target that needs to embed Flutter, call
YourApp/Podfile
```sh
target 'YourApp' do
  install_all_flutter_pods(flutter_application_path)
end
```

##### For each Podfile target that needs to embed Flutter, call
In the Podfile’s post_install block, call flutter_post_install(installer).
YourApp/Podfile
```sh
post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
```
After that, run the pod install
```sh
pod install
```
The podhelper.rb script embeds FlourishFI plugins, Flutter.framework, and App.framework into your project.


## Implementation
### Start a FlutterEngine and FlutterViewController

To launch our Flutter module to your existing iOS App, you start a FlutterEngine and a FlutterViewController.

YourApp.swift
```swift
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
struct YourApp: App {
    @StateObject var flutterDependencies = FlutterDependencies()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(flutterDependencies)
        }
    }
}
```
In this example, we create a FlutterEngine object inside a SwiftUI ObservableObject. We then pass this FlutterEngine to a ContentView using the EnvironmentObject() property.

### Show a FlutterViewController with your FlutterEngine

The following example shows a generic ContentView with a Button hooked to present a FlutterViewController.

The FlutterViewController constructor takes the pre-warmed FlutterEngine as an argument. FlutterEngine is passed in as an EnvironmentObject via flutterDependencies.

```swift
import SwiftUI
import Flutter

struct ContentView: View {
    @EnvironmentObject var flutterDependencies: FlutterDependencies
    
    var body: some View {
        VStack(spacing: 10) {
            Text("This is a native iOS App, click the button below to open our \n module in Flutter")
        
            Button("Open FlourishFI Flutter module") {
                showFlutter()
            }
        }
        .padding()
    }
    
    func showFlutter() {
        guard
          let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive && $0 is UIWindowScene }) as? UIWindowScene,
          let window = windowScene.windows.first(where: \.isKeyWindow),
          let rootViewController = window.rootViewController
        else { return }

        let flutterViewController = FlutterViewController(
          engine: flutterDependencies.flutterEngine,
          nibName: nil,
          bundle: nil)
        flutterViewController.modalPresentationStyle = .overCurrentContext
        flutterViewController.isViewOpaque = false

        rootViewController.present(flutterViewController, animated: true)
    }
}

```
Now, you have our Flutter module embedded in your iOS app.


## Examples
___
Inside this repository, you have an example to show how to integrate:

https://github.com/Flourish-savings/flourish-ios-flutter-example/tree/main/flourish-ios-flutter-example
<br>
