#
# Be sure to run `pod lib lint YTXTest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YTXTest"
  s.version          = "0.1.1"
  s.summary          = "Test."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = " use test"

  s.homepage         = "https://github.com/BruceLilonglong/YTXTest"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "lilonglong" => "596927598@qq.com" }
  s.source           = { :git => "https://github.com/BruceLilonglong/YTXTest.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'YTXTest' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  NSArray = {:spec_name => "NSArray", :source_files =>['Pod/Classes/**/NSArray+*.{h,m}']}
  
  NSURL = {:spec_name => "NSURL", :source_files =>['Pod/Classes/**/NSURL+*.{h,m}']}
  
  UIImage = {:spec_name => "UIImage", :source_files =>['Pod/Classes/**/UIImage+*.{h,m}']}
  
  UITextView = {:spec_name => "UITextView", :source_files =>['Pod/Classes/**/UITextView+*.{h,m}']}
  
  UIAll = {:spec_name => "UIAll", :sub_dependency => [UIImage, UITextView]}
  
  FoundationAll = {:spec_name => "FoundationAll", :sub_dependency => [NSArray, NSURL]}
  
  $all_name = []
  
   $all_spec = [NSArray, NSURL, UIImage, UITextView, UIAll, FoundationAll]
  
  $all_spec.each do |spec|
      s.subspec spec[:spec_name] do |ss|
          
          $all_name << spec[:spec_name]
          
          if spec[:source_files]
              ss.source_files = spec[:source_files]
          end
          
          if spec[:sub_dependency]
              spec[:sub_dependency].each do |dep|
                  ss.dependency "YTXTest/#{dep[:spec_name]}"
              end
          end
          
      end
   end
  
  spec_names = $all_name[0...-1].join(", ") + " 和 " + $all_name[-1]
  s.description = "subspec:#{spec_names}"
  
end
