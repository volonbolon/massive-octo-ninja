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
#import "VBLateralViewController.h"
#import "FWKReusableCacheInformation.h"
#import "FWKLateralReusableController.h"
#import "VBLateralViewController.h"

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
    id navigatorPartialMock = [OCMockObject partialMockForObject:navigator];
    [[navigatorPartialMock expect] loadChildViewController:[OCMArg checkWithBlock:^BOOL(id obj) {
        return [obj isKindOfClass:[VBLateralViewController class]];
    }]];
    id navigatorDataSourceMock = [OCMockObject mockForProtocol:@protocol(FWKLateralNavigatorDataSource)];
    
    [[[navigatorDataSourceMock expect] andReturnValue:[NSNumber numberWithUnsignedInteger:3]] numberOfItemsInLateralNavigator:[OCMArg isNotNil]];
    VBLateralViewController *vc = [[VBLateralViewController alloc] initWithNibName:@"VBLateralViewController"
                                                                            bundle:nil];
    [[[navigatorDataSourceMock expect] andReturn:vc] lateralNavigator:[OCMArg isNotNil] viewControllerForIndex:0];
    
    [navigator setDataSource:navigatorDataSourceMock];
    
    [navigator viewDidLoad];
    
    XCTAssertTrue([navigator numberOfItems]==3, @"number of items (%d) should be 3", [navigator numberOfItems]);
    
    [navigatorDataSourceMock verify];
    [navigatorPartialMock verify];
    
}

- (void)testRegisterClass
{
    
    FWKLateralNavigator *navigator = [FWKLateralNavigator new];
    
    XCTAssertTrue([[[navigator cache] allKeys] count]==0, @"cache should be nil");
    
    [navigator registerClass:[UIViewController class]
 forControllerWithIdentifier:@"someIdentifier"];
    
    XCTAssertTrue([[[navigator cache] allKeys] count]==1, @"cache should countains 1 element");
    
}

- (void)testExceptionIfNoClassHasBeenRegistered
{
    
    FWKLateralNavigator *navigator = [FWKLateralNavigator new];
    
    XCTAssertThrows([navigator dequeueReusableControllerWithIdentifier:@"someIdentifier"], @"Exception should be thrown");
    
}

- (void)testDequeWithEmptyCache
{
    
    NSString *identifier = @"VBLateralViewController";
    FWKLateralNavigator *navigator = [FWKLateralNavigator new];
    [navigator registerClass:[VBLateralViewController class]
 forControllerWithIdentifier:identifier];
    
    UIViewController *controller = [navigator dequeueReusableControllerWithIdentifier:identifier];
    FWKReusableCacheInformation *rci = [[navigator cache] objectForKey:identifier];
    XCTAssertTrue([[rci cache] count]==1, @"There should be one element in the vc cache");
    XCTAssertTrue([controller conformsToProtocol:@protocol(FWKLateralReusableController)], @"returned controller should conform to protocol 'FWKLateralReusableController'");
    
}

- (void)testDequeWithFullCache
{
    
    NSString *identifier = @"VBLateralViewController";
    FWKLateralNavigator *navigator = [FWKLateralNavigator new];
    [navigator registerClass:[VBLateralViewController class]
 forControllerWithIdentifier:identifier];
    
    for ( NSUInteger n = 0; n <= 3; n++ ) {
        
        [navigator dequeueReusableControllerWithIdentifier:identifier];

        
    }
    
    FWKReusableCacheInformation *rci = [[navigator cache] objectForKey:identifier];
    
    UIViewController *firstElement = [[rci cache] firstObject];
    
    [navigator dequeueReusableControllerWithIdentifier:identifier];
    
    XCTAssertTrue([firstElement isEqual:[[rci cache] lastObject]], @"first element should be send to last position after dequeuing");
    
}

@end
