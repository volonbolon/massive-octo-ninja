//
//  FWKLateralNavigator.m
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/24/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import "FWKLateralNavigator_Private.h"

@implementation FWKLateralNavigator

- (id)init
{
    
    self = [super initWithNibName:@"FWKLateralNavigator"
                           bundle:nil];
    
    if ( self != nil ) {
        
        
        
    }
    
    return self;
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    NSObject <FWKLateralNavigatorDataSource> *dataSource = [self dataSource];
    NSUInteger numberOfItems = [dataSource numberOfItemsInLateralNavigator:self];
    [self setNumberOfItems:numberOfItems];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    
    [super didMoveToParentViewController:parent];
    
    if ( parent != nil ) {
        
        [self setParentNavigationController:[parent navigationController]];
        
    }
    
}

- (void)registerClass:(Class)controllerClass forControllerWithIdentifier:(NSString *)identifier
{
    
    
    
}

- (IBAction)previousButtonTapped:(id)sender
{
}

- (IBAction)nextButtonTapped:(id)sender
{
    
}
@end
