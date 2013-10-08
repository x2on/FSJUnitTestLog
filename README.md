# FSJUnitTestLog [![Cocoa Pod](https://cocoapod-badges.herokuapp.com/p/FSJUnitTestLog/badge.svg)](http://cocoadocs.org/docsets/FSJUnitTestLog/) [![Cocoa Pod](https://cocoapod-badges.herokuapp.com/v/FSJUnitTestLog/badge.svg)](http://cocoadocs.org/docsets/FSJUnitTestLog/)


FSJunitTestLog is a XCTestObserver implementation for iOS 7+ XCTests, which converts the test results to an JUnit XML Results file.

## Install
Using [CocoaPods](http://cocoapods.org/):

```
target :YourTestTarget do
	pod 'FSJUnitTestLog', '~> 1.0'
end
```

## Basic usage

Add the code at the beginning of your app delegate: 

```objc
#ifdef DEBUG
    const char *env = getenv("FSJUnitTestLog");
    if (env) {
        NSLog(@"Run Unit-Tests with FSJUnitTestLog");
        [[NSUserDefaults standardUserDefaults] setObject:@"XCTestLog,FSJUnitTestLog" forKey:@"XCTestObserverClass"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
#endif
```

Edit your scheme, go to "Test" - "Arguments" and add the Environment Variable `FSJUnitTestLog` with the value `1`

![Settings Screen](https://raw.github.com/x2on/FSJUnitTestLog/master/FSJUnitTestLogExample/Screen.png)

## Continuous Integration

### TeamCity

[TeamCity](http://www.jetbrains.com/teamcity/) support is integrated. TeamCity automatically imports the generated JUnit.xml file with service messages.

### Jenkins

[Jenkins](http://jenkins-ci.org/) support is integrated, but you must install the [JUnit Attachments Plugin](https://wiki.jenkins-ci.org/display/JENKINS/JUnit+Attachments+Plugin).

## Demo

The demo project uses [CocoaPods](http://cocoapods.org/) for dependency management.

Install dependencies: `pod install`

## License

FSJunitTestLog is available under the MIT license. See the LICENSE file for more info.

