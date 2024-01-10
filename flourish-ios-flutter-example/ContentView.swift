import SwiftUI
import Flutter

struct ContentView: View {
    @EnvironmentObject var flutterDependencies: FlutterDependencies
    
    var body: some View {
        ZStack{
            VStack(spacing: 10) {
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 30, leading: 100, bottom: 100, trailing: 100))
                Text("This is a native iOS App, click the button below to open our \n module in Flutter")
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 100, trailing: 30))
                
                Button("Open FlourishFI Flutter module") {
                    showFlutter()
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .padding()
        }
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
