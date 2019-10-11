# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/marutharaj/AFPodSpecs.git'

target 'AirportFinder' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AirportFinder
  pod 'PromiseKit', '~> 6.0'
  pod 'SwiftLint'
  pod 'AFHandy'

  target 'AirportFinderTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble', '7.3.3'
    pod 'AFHandy'
  end

  target 'AirportFinderUITests' do
    inherit! :search_paths
    # Pods for testing
    pod 'PromiseKit', '~> 6.0'
    pod 'AFHandy'
  end

end
