#
# Be sure to run `pod lib lint LWKBCommonUtils_swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LWKBCommonUtils_swift'
  s.version          = '1.0.0'
  s.summary          = 'LWKBCommonUtils的Swift版本，提供常用工具类和SwiftUI扩展。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
LWKBCommonUtils_swift，Swift版本的通用工具库，包含应用定义、数据管道管理、SwiftUI扩展等实用功能。
                       DESC

  s.homepage         = 'https://gitlab.com/ioslibraries1/lwkbcommonutils.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luowei' => 'luowei@wodedata.com' }
  s.source           = { :git => 'https://gitlab.com/ioslibraries1/lwkbcommonutils.git' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'

  s.source_files = 'LWKBCommonUtils_swift/Classes/**/*'

  # s.resource_bundles = {
  #   'LWKBCommonUtils_swift' => ['LWKBCommonUtils_swift/Assets/*.png']
  # }

  # s.frameworks = 'UIKit', 'SwiftUI'
  # s.dependency 'AFNetworking', '~> 2.3'
end
