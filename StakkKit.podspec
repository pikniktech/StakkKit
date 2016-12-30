#
# Be sure to run `pod lib lint StakkKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StakkKit'
  s.version          = '1.0.0'
  s.summary          = 'This a helper kit for Stakk developers to develop iOS applications.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This a helper kit for Stakk developers to develop iOS applications.
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/pikniktech/sf-stakkkit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Derek' => 'derek@stakkfactory.com' }
  s.source           = { :git => 'https://github.com/pikniktech/sf-stakkkit-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.3'

  s.source_files = 'StakkKit/Classes/**/*{h,m}'
  s.resources = 'StakkKit/*{xcdatamodeld}'

  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'JSONModel', '~> 1.5.1'
  s.dependency 'CocoaLumberjack', '~> 3.0.0'
  s.dependency 'MagicalRecord', '~> 2.3.2'
  s.dependency 'PureLayout', '~> 3.0.2'
  s.dependency 'SDWebImage', '~> 3.8.2'
  s.dependency 'libextobjc/EXTScope', '~> 0.4.1'
end
