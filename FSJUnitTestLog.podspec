Pod::Spec.new do |s|
  s.name         = "FSJUnitTestLog"
  s.version      = "0.9.0"
  s.summary      = "FSJUnitTestLog is a XCTestObserver implementation, which converts the test results to an JUnit XML Results file."
  s.homepage     = "https://github.com/x2on/FSJUnitTestLog"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Felix Schulze" => "code@felixschulze.de" }
  s.source       = { 
    :git => "https://github.com/x2on/FSJUnitTestLog.git",
    :tag => "0.9.0"
  }

  s.platform     = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'FSJUnitTestLog.{h,m}'
  s.framework	 = 'XCTest', 'Foundation'
  s.dependency 'GDataXML-HTML', '~> 1.1.0'

end