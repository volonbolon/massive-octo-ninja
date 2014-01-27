//
//  FWKLateralNavigator.h
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/24/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FWKLateralReusableController;
@protocol FWKLateralNavigatorDataSource;

/**
 This class is used to compose a collection container. 
 On top a tool bar is presented with two buttons, one to get the previous item, and one to get the next item. The items are presented in the main area.
 We are subclassing from UIViewController to use containment.
 The system uses NSLayoutConstraints to fill the entire area of the view where it is presented.
 */
@interface FWKLateralNavigator : UIViewController
/**
 Intance of an object that conforms to `FWKLateralNavigatorDataSource` and is queried to feed the elements to the controller. In many aspect, it is like `UITableViewDataSource`
 */
@property (nonatomic, weak) NSObject<FWKLateralNavigatorDataSource> *dataSource;

/**
 Used to register the class into an internal cache. The controllers had to conform to `FWKLateralReusableController`.
 @param controllerClass The `Class` of the each view controller that will be used for the main portion of the screen.
 @param identifier `NSString` used as a key to save the `Class` and a cache of available controllers to be reused. Keys has to be uniques. If two keys crash, the system will save only the class associated with the last one
 */
- (void)registerClass:(Class)controllerClass forControllerWithIdentifier:(NSString *)identifier;

/**
 In order to prevent the costly initialization of many controllers, the system keeps a cache. Clients should query this API to obtain a controller associated with the key ready to be reuse. 
 @param identifier NSString instance of the key used to identify the controller class
 @warning if the identifier has not been registered previously, the system trows an exception.
 */
- (UIViewController <FWKLateralReusableController>*)dequeueReusableControllerWithIdentifier:(NSString *)identifier;
@end
