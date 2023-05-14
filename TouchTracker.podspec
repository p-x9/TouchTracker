
Pod::Spec.new do |spec|

  spec.name         = "TouchTracker"
  spec.version      = "0.2.1"
  spec.summary      = "Show a mark at the touched point on the View of SwiftU and UIKit."

  spec.homepage     = "https://github.com/p-x9/TouchTracker"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "p-x9" => "p.x9.dev@gmail.com" }

  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/p-x9/TouchTracker.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/TouchTracker/**/*.{swift}"

  spec.swift_version = '5.8'

end
