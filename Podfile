target 'flourish-ios-flutter-example' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for newsfeed_app
  flutter_application_path = '../flourish_flutter_module'
  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
  install_all_flutter_pods(flutter_application_path)

  post_install do |installer|
    flutter_post_install(installer) if defined?(flutter_post_install)
  end

end
