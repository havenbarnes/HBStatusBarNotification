#
# Be sure to run `pod lib lint HBStatusBarNotification.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HBStatusBarNotification'
  s.version          = '0.1.0'
  s.summary          = 'An extremely lightweight solution to dispatching status bar notifications from anywhere in your iOS application.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/havenbarnes/HBStatusBarNotification'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'havenbarnes' => 'haven38@gmail.com' }
  s.source           = { :git => 'https://github.com/havenbarnes/HBStatusBarNotification.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/havenb3'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HBStatusBarNotification/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HBStatusBarNotification' => ['HBStatusBarNotification/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
