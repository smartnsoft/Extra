Pod::Spec.new do |s|
  s.name             = 'Extra'
  s.version          = '1.2.1'
  s.summary          = 'Swift library with usefull and lightfull extensions for your Cocoa Touch projects.'

  s.homepage         = 'https://github.com/smartnsoft/Extra'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Smart&Soft' => 'contact@smartnsoft.com' }
  s.source           = { :git => 'https://github.com/smartnsoft/Extra.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.3'
  s.tvos.deployment_target = '9.3'
  s.swift_version          = '5'

  s.ios.frameworks        = 'UIKit', 'Foundation', 'QuartzCore'

  s.default_subspec = 'UIKit', 'Foundation', 'CoreAnimation'

  s.subspec 'UIKit' do |sp|
    sp.source_files = 'Extra/Classes/Extra/**/*.{swift}', 'Extra/Classes/UIKit/**/*.{swift}'
  end

  s.subspec 'Foundation' do |sp|
    sp.source_files = 'Extra/Classes/Extra/**/*.{swift}', 'Extra/Classes/Foundation/**/*.{swift}'
  end

  s.subspec 'CoreAnimation' do |sp|
    sp.source_files = 'Extra/Classes/Extra/**/*.{swift}', 'Extra/Classes/CoreAnimation/**/*.{swift}'
  end

  s.subspec 'Realm' do |sp|
    sp.source_files = 'Extra/Classes/Extra/**/*.{swift}','Extra/Classes/Realm/**/*.{swift}'
    sp.dependency 'RealmSwift', '~> 3.10'
  end
end
