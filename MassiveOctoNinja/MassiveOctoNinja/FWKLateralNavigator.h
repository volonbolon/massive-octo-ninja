//
//  FWKLateralNavigator.h
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/24/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FWKLateralNavigatorDataSource;

@interface FWKLateralNavigator : UIViewController
@property (nonatomic, weak) NSObject<FWKLateralNavigatorDataSource> *dataSource;

- (void)registerClass:(Class)controllerClass forControllerWithIdentifier:(NSString *)identifier;
@end
