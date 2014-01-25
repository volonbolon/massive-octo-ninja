//
//  FWKLateralNavigatorDataSource.h
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/25/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FWKLateralNavigator;
@protocol FWKLateralReusableController;

@protocol FWKLateralNavigatorDataSource <NSObject>
@required
- (UIViewController <FWKLateralReusableController> *)lateralNavigator:(FWKLateralNavigator *)lateralNavigator
                                               viewControllerForIndex:(NSUInteger)index;
- (NSInteger)numberOfItemsInLateralNavigator:(FWKLateralNavigator *)lateralNavigator;
@end
