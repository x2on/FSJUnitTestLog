Pod::Spec.new do |s|
  s.name         = "FSJunitTestLog"
  s.version      = "0.9.0"
  s.summary      = "FSJunitTestLog is a ...."
  s.homepage     = "https://github.com/x2on/FSJunitTestLog"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Felix Schulze" => "code@felixschulze.de" }
  s.source       = { 
    :git => "https://github.com/x2on/FSJunitTestLog.git",
    :tag => "0.9.0"
  }

  s.platform     = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'FSJUnitTestLog.{h,m}'
  s.framework	 = 'XCTest', 'Foundation'
  s.dependency 'GDataXML-HTML', '~> 1.1.0'

end