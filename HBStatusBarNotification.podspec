#
# Be sure to run `pod lib lint HBStatusBarNotification.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HBStatusBarNotification'
  s.version          = '1.1.0'
  s.summary          = 'An extremely lightweight solution to dispatching status bar notifications from anywhere in your iOS application.'

  s.description      = <<-DESC
HBStatusBarNotification provides a simple one-liner for dispatching a text-based notification that will overlay the status bar for a short duration. It offers a range of customization options so that you can make the notification appear however you would like it to.

    I made this because it's something a lot of iOS developers want in their application, but I found a lot of the existing options require more code and offer less customization. I wanted a solution that looked like it came from the same developer and wasn't obviously a library that I had dragged into my project.
                       DESC

  s.homepage         = 'https://github.com/havenbarnes/HBStatusBarNotification'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'havenbarnes' => 'haven38@gmail.com' }
  s.source           = { :git => 'https://github.com/havenbarnes/HBStatusBarNotification.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/havenb3'

  s.ios.deployment_target = '11.0'

  s.source_files = 'HBStatusBarNotification/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HBStatusBarNotification' => ['HBStatusBarNotification/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
end
