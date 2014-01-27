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

/**
 Protocol that needs to be adopted by instances that are going to be feeding the lateral controller. Should be thought as a decaffeinated version of others dataSoruce of collections, like `UITableViewDataSource`
 */
@protocol FWKLateralNavigatorDataSource <NSObject>
@required
/**
 The datasource should return a configured class of the controller expected for the index. 
 @discussion Specially if many items are shown, the controllers should be reused. The lateal navigator provides the API `-dequeueReusableControllerWithIdentifier:` to let clients easily obtain a reusable instance of the controller associated with the index. 
 @param lateralNavigator the instance of the lateral navigator that is asking for the controller
 @param index the index that needs to be filled with the controller
 */
- (UIViewController <FWKLateralReusableController> *)lateralNavigator:(FWKLateralNavigator *)lateralNavigator
                                               viewControllerForIndex:(NSUInteger)index;

/**
 How many items are going to be shown controller?
 @param lateralNavigator the instance of the lateral navigator tjhat is asking the number of items that need to be shown
 */
- (NSInteger)numberOfItemsInLateralNavigator:(FWKLateralNavigator *)lateralNavigator;
@end
