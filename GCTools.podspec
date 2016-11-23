Pod::Spec.new do |s|
    s.name         = "GCTools"
    s.version      = "0.0.2"
    s.summary      = "A common tool IOS of GCTools"
    s.homepage     = "https://github.com/XiaoHanGe/GCTools"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "韩俊强" => "532167805@qq.com" }
    s.platform     = :ios, "7.0"
    s.ios.deployment_target = "7.0"
    s.source       = { :git => "https://github.com/XiaoHanGe/GCTools.git", :tag => s.version.to_s }
    s.source_files  = "GCTools/**/*.{h,m}"
    s.public_header_files = "GCTools/**/*.h"
    s.frameworks  = "UIKit","Foundation"
    s.requires_arc = true
end
