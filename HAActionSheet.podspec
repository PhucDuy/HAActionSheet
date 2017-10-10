Pod::Spec.new do |s|
  s.name             = 'HAActionSheet'
  s.version          = '0.1.9'
  s.summary          = 'HAActionSheet is a dynamic action sheet for iOS.'
  s.description      = <<-DESC
HAActionSheet is a dynamic action sheet for iOS written in Swift 3.0.
                       DESC

  s.homepage         = 'https://github.com/hasanlsn/HAActionSheet'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hasanlsn' => 'hasanalisn@gmail.com' }
  s.source           = { :git => 'https://github.com/hasanlsn/HAActionSheet.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nnasanali'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HAActionSheet/Classes/**/*'
  
   s.resource_bundles = {
     'HAActionSheet' => ['HAActionSheet/Resources/**/*.{png,jpeg,jpg,storyboard,xib}']
   }
end
