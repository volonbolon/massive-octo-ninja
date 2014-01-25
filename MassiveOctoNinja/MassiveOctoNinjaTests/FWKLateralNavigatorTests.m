//
//  FWKLateralNavigatorTests.m
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/25/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FWKLateralNavigator.h"
#import "FWKLateralNavigator_Private.h"
#import "FWKLateralNavigatorDataSource.h"

#import <OCMock/OCMock.h>

@interface FWKLateralNavigatorTests : XCTestCase

@end

@implementation FWKLateralNavigatorTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testOCMockPass
{
    id mock = [OCMockObject mockForClass:NSString.class];
    [[[mock stub] andReturn:@"mocktest"] lowercaseString];
    
    NSString *returnValue = [mock lowercaseString];
    XCTAssertEqualObjects(@"mocktest", returnValue, @"Should have returned the expected string.");
    
}

- (void)testViewDidLoad
{
    
    FWKLateralNavigator *navigator = [FWKLateralNavigator new];
    id navigatorDataSourceMock = [OCMockObject mockForProtocol:@protocol(FWKLateralNavigatorDataSource)];
    
    [[[navigatorDataSourceMock expect] andReturnValue:[NSNumber numberWithUnsignedInteger:3]] numberOfItemsInLateralNavigator:[OCMArg isNotNil]];
    
    [navigator setDataSource:navigatorDataSourceMock];
    
    [navigator viewDidLoad];
    
    XCTAssertTrue([navigator numberOfItems]==3, @"number of items (%d) should be 3", [navigator numberOfItems]);
    
    [navigatorDataSourceMock verify];
    
}

@end
