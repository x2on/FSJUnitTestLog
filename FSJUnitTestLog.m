//  FSJUnitTestLog
//
//  Created by Felix Schulze on 9/20/2013.
//  Copyright 2013 Felix Schulze. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "FSJUnitTestLog.h"
#import "GDataXMLNode.h"

@implementation FSJUnitTestLog

- (void)startObserving {
    self.document = [[GDataXMLDocument alloc] init];
    self.document = [_document initWithRootElement:[GDataXMLElement elementWithName:@"testsuites"]];
    self.suitesElement = [_document rootElement];

    [super startObserving];
}

- (void)stopObserving {
    [self _writeResultFile];

    [super stopObserving];
}

- (void)testSuiteDidStart:(XCTestRun *)testRun {
    XCTestSuite *testSuite = (XCTestSuite *) [testRun test];
    self.currentSuiteElement = [GDataXMLElement elementWithName:@"testsuite"];
    [_currentSuiteElement addAttribute:[GDataXMLNode attributeWithName:@"name" stringValue:[testSuite name]]];
}

- (void)testSuiteDidStop:(XCTestRun *)testRun {
    XCTestSuiteRun *testSuiteRun = (XCTestSuiteRun *) testRun;

    if (_currentSuiteElement) {
        [_currentSuiteElement addAttribute:[GDataXMLNode attributeWithName:@"name" stringValue:[[testSuiteRun test] name]]];
        [_currentSuiteElement addAttribute:[GDataXMLNode attributeWithName:@"tests" stringValue:[NSString stringWithFormat:@"%d", [testSuiteRun testCaseCount]]]];
        [_currentSuiteElement addAttribute:[GDataXMLNode attributeWithName:@"errors" stringValue:[NSString stringWithFormat:@"%d", [testSuiteRun unexpectedExceptionCount]]]];
        [_currentSuiteElement addAttribute:[GDataXMLNode attributeWithName:@"failures" stringValue:[NSString stringWithFormat:@"%d", [testSuiteRun failureCount]]]];
        [_currentSuiteElement addAttribute:[GDataXMLNode attributeWithName:@"skipped" stringValue:@"0"]];
        [_currentSuiteElement addAttribute:[GDataXMLNode attributeWithName:@"time" stringValue:[NSString stringWithFormat:@"%f", [testSuiteRun testDuration]]]];
        [_suitesElement addChild:_currentSuiteElement];
        self.currentSuiteElement = nil;
    }
}

- (void)testCaseDidStart:(XCTestRun *)testRun {
    XCTest *test = [testRun test];
    self.currentCaseElement = [GDataXMLElement elementWithName:@"testcase"];
    [_currentCaseElement addAttribute:[GDataXMLNode attributeWithName:@"name" stringValue:[test name]]];
}

- (void)testCaseDidStop:(XCTestRun *)testRun {
    XCTestCaseRun *testCaseRun = (XCTestCaseRun *) testRun;
    XCTest *test = [testCaseRun test];

    [_currentCaseElement addAttribute:[GDataXMLNode attributeWithName:@"name" stringValue:[test name]]];
    [_currentCaseElement addAttribute:[GDataXMLNode attributeWithName:@"classname" stringValue:NSStringFromClass([test class])]];
    [_currentCaseElement addAttribute:[GDataXMLNode attributeWithName:@"time" stringValue:[NSString stringWithFormat:@"%f", [testCaseRun testDuration]]]];
    [_currentSuiteElement addChild:_currentCaseElement];
    self.currentCaseElement = nil;
}

- (void)testCaseDidFail:(XCTestRun *)testRun withDescription:(NSString *)description inFile:(NSString *)filePath atLine:(NSUInteger)lineNumber; {
    GDataXMLElement *failureElement = [GDataXMLElement elementWithName:@"failure"];
    [failureElement setStringValue:description];
    [_currentCaseElement addChild:failureElement];
}

#pragma mark - Helper

- (void)_writeResultFile; {
    if (self.document) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [NSString stringWithFormat:@"%@/junit.xml", paths[0]];

        BOOL saved = [[_document XMLData] writeToFile:filePath atomically:NO];
        if (saved) {
            NSLog(@"##teamcity[importData type='junit' path='%@']", filePath);
            NSLog(@"[[ATTACHMENT|%@]]", filePath);
        }
        else {
            NSLog(@"##teamcity[buildStatus status='FAILURE' text='Error while saving test results.']");
        }
    }
    else {
        NSLog(@"ERROR: No document to write.");
    }
}

@end
