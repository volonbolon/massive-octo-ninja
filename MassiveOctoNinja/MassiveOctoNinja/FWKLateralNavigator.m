//
//  FWKLateralNavigator.m
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/24/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import "FWKLateralNavigator_Private.h"
#import "FWKLateralReusableController.h"
#import "FWKReusableCacheInformation.h"

@implementation FWKLateralNavigator

- (id)init
{
    
    self = [super initWithNibName:@"FWKLateralNavigator"
                           bundle:nil];
    
    if ( self != nil ) {
        
        _cache = [NSMutableDictionary new];
        
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
    
    FWKReusableCacheInformation *rci = [FWKReusableCacheInformation new];
    [rci setControllerClass:controllerClass];
    [rci setCache:[NSMutableArray array]];
    
    [[self cache] setObject:rci
                     forKey:identifier];
    
}

- (UIViewController <FWKLateralReusableController>*)dequeueReusableControllerWithIdentifier:(NSString *)identifier
{
    
    FWKReusableCacheInformation *reusableInformation = [[self cache] objectForKey:identifier];
    
    if ( reusableInformation == nil ) {
        
        [NSException raise:NSLocalizedString(@"Invalid Identifier", @"Title for exception throwed if no class has been registered for the identifier")
                    format:NSLocalizedString(@"No class has been registered", @"Message for exception throwed if no class has been registered for the identifier")];
        
    }
    
    NSMutableArray *cache = [reusableInformation cache];
    UIViewController *reusableViewController = nil;
    if ( [reusableInformation cacheIsReady] ) {
        
        reusableInformation = [cache lastObject];
        [cache removeLastObject];
        
    } else {
        
        Class controllerClass = [reusableInformation controllerClass];
        
        reusableViewController = [(UIViewController *)[controllerClass alloc] initWithNibName:NSStringFromClass(controllerClass)
                                                                                       bundle:nil];
        
        if ( [reusableViewController conformsToProtocol:@protocol(FWKLateralReusableController)] ) {
            
            [cache addObject:reusableViewController];
            
        } else {
            
            reusableViewController = nil;
            
        }

        
    }
    
    return (UIViewController<FWKLateralReusableController>*)reusableViewController;
    
}

- (IBAction)previousButtonTapped:(id)sender
{
}

- (IBAction)nextButtonTapped:(id)sender
{
    
}
@end
