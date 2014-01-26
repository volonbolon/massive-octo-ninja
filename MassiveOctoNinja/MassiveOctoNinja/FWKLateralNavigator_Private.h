//
//  FWKLateralNavigator_Private.h
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/25/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import "FWKLateralNavigator.h"
#import "FWKLateralReusableController.h"
#import "FWKLateralNavigatorDataSource.h"

@interface FWKLateralNavigator ()
@property (nonatomic, strong) UINavigationController *parentNavigationController;
@property (nonatomic, assign) NSUInteger numberOfItems;
@property (nonatomic, strong) NSMutableDictionary *cache;
@property (weak, nonatomic) IBOutlet UIView *controllersContainer;

- (IBAction)previousButtonTapped:(id)sender;
- (IBAction)nextButtonTapped:(id)sender;

- (void)loadChildViewController:(UIViewController *
                                 )childViewController;

@end