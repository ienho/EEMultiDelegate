#
# Be sure to run `pod lib lint EEMultiDelegate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EEMultiDelegate'
  s.version          = '0.2.0'
  s.summary          = "A multicast-delegate class with thread-safe"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    A multicast-delegate class with thread-safe
    一个线程安全的`多播-代理`的实现
                       DESC

  s.homepage         = 'https://github.com/ienho/EEMultiDelegate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ian' => 'hyhshiwool@163.com' }
  s.source           = { :git => 'https://github.com/ienho/EEMultiDelegate.git', :tag => s.version.to_s }
  s.platform         = :ios, "8.0"
  
  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.source_files = 'EEMultiDelegate/Classes/*.{h,m,c}'
  s.public_header_files = 'EEMultiDelegate/Classes/*.h'

end
