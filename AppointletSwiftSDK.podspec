Pod::Spec.new do |spec|
    spec.name         = "AppointletSwiftSDK"
    spec.version      = "1.0.0"
    spec.summary      = "Swift SDK for integrating Appointlet functionalities within Apple platforms."
    spec.description  = <<-DESC
                        This SDK provides tools for integrating Appointlet's services, like scheduling and booking, into iOS, iPadOS, and macOS applications using Swift.
                      DESC
    spec.homepage     = "https://github.com/appointlet/swift-sdk"
    spec.license      = { :type => "MIT", :file => "LICENSE" }
    spec.author       = { "Appointlet" => "help@appointlet.com" }
    spec.platform     = :ios, "10.0"
    spec.source       = { :git => "https://github.com/appointlet/swift-sdk.git", :tag => "#{spec.version}" }
    spec.source_files  = "Sources/**/*"
    spec.swift_version = "5.0"
  end
  