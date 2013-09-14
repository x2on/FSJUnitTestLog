# FSJUnitTestLog

FSJunitTestLog is a XCTestObserver implementation for iOS 7+ XCTests, which converts the test results to an JUnit XML Results file.

## Install
Using [CocoaPods](http://cocoapods.org/):

```
target :YourTestTarget do
	pod 'FSJUnitTestLog', '~> 0.9.0'
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

## Demo

The demo project uses [CocoaPods](http://cocoapods.org/) for dependency management.

Install dependencies: `pod install`

## License

FSJunitTestLog is available under the MIT license. See the LICENSE file for more info.

