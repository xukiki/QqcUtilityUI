Pod::Spec.new do |s|

  s.license      = "MIT"
  s.author       = { "qqc" => "20599378@qq.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc  = true

  s.name         = "QqcUtilityUI"
  s.version      = "1.0.88"
  s.summary      = "QqcUtilityUI"
  s.homepage     = "https://github.com/xukiki/QqcUtilityUI"
  s.source       = { :git => "https://github.com/xukiki/QqcUtilityUI.git", :tag => "#{s.version}" }
  
  s.source_files  = ["QqcUtilityUI/*.{h,m}"]
  s.dependency "QqcFontDef"
  s.dependency "QqcSizeDef"
  s.dependency "QqcColorDef"
  s.dependency "QqcMarginDef"
  s.dependency "QqcUtility"
  s.dependency "NSString-Qqc"
  
end
