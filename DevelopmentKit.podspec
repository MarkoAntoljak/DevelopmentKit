Pod::Spec.new do |s|

  s.name = "DevelopmentKit"
  s.version = "1.0.1"
  s.summary = "Useful library written in Swift for easier development"
  s.ios.deployment_target = "13.0"

  s.swift_version = '5'

  s.description  = <<-DESC
                  This is a Swift framework written for easier use of some basic Swift functions and elements within UIKit.
  DESC

 s.license = { :type => 'MIT', :file => 'LICENSE' }


  s.author = { "Marko Antoljak" => "marko.antoljak6@gmail.com" }
  s.homepage     = "https://github.com/MarkoAntoljak/DevelopmentKit"
  s.source = { :git => "https://github.com/MarkoAntoljak/DevelopmentKit.git", :tag => "#{s.version}" }
 s.dependency 'SkeletonView'
 s.dependency 'SnapKit'
 s.dependency 'Kingfisher'
 s.source_files  = "Source/**/*.{swift,h}"

end