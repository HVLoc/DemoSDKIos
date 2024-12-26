# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'DemoSDKIos' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DemoSDKIos
  flutter_application_path = '/Users/apple/LocHV/Flutter/module_ekyc'
  
  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

  install_all_flutter_pods(flutter_application_path)
  
#  target 'DemoSDKIosTests' do
#    inherit! :search_paths
#    # Pods for testing
#  end
#
#  target 'DemoSDKIosUITests' do
#    # Pods for testing
#  end

end

post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
