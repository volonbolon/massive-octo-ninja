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
    
    [self setCurrentIndex:0];
    
    if ( numberOfItems > 0 ) {
        
        [[self previousButton] setEnabled:NO];
        
        UIViewController *childViewController = [dataSource lateralNavigator:self
                                                      viewControllerForIndex:0];
        
        [self loadChildViewController:childViewController];
        
    }
    
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
        
        reusableViewController = [cache firstObject];
        [cache removeObjectAtIndex:0];
        [cache addObject:reusableViewController];
        
    } else {
        
        Class controllerClass = [reusableInformation controllerClass];
        
        NSString *stringFromClass = NSStringFromClass(controllerClass);
        NSString *nibName =  [[NSBundle mainBundle] pathForResource:stringFromClass ofType:@"nib"] == nil ? nil : stringFromClass;
        
        reusableViewController = [(UIViewController *)[controllerClass alloc] initWithNibName:nibName
                                                                                       bundle:nil];
        
        if ( [reusableViewController conformsToProtocol:@protocol(FWKLateralReusableController)] ) {
            
            [cache addObject:reusableViewController];
            [(UIViewController<FWKLateralReusableController>*)reusableViewController setIdentifier:identifier];
            
        } else {
            
            reusableViewController = nil;
            
        }
        
        
    }
    
    return (UIViewController<FWKLateralReusableController>*)reusableViewController;
    
}

- (IBAction)previousButtonTapped:(id)sender
{
    
    if ( [self currentIndex] > 0 ) {
        
        [self setCurrentIndex:[self currentIndex]-1];
        
        UIViewController *childViewController = [[self childViewControllers] firstObject];
        UIViewController *toViewController = [[self dataSource] lateralNavigator:self
                                                          viewControllerForIndex:[self currentIndex]];
        
        [self flipFromViewController:(UIViewController<FWKLateralReusableController>*)childViewController
                toViewViewController:(UIViewController<FWKLateralReusableController>*)toViewController];
        
    }
    
    [self toggleButtons];
    
}

- (IBAction)nextButtonTapped:(id)sender
{
    
    if ( [self currentIndex]+1 < [self numberOfItems] ) {
        
        [self setCurrentIndex:[self currentIndex]+1];
        
        UIViewController *childViewController = [[self childViewControllers] firstObject];
        UIViewController *toViewController = [[self dataSource] lateralNavigator:self
                                                          viewControllerForIndex:[self currentIndex]];
        
        [self flipFromViewController:(UIViewController<FWKLateralReusableController>*)childViewController
                toViewViewController:(UIViewController<FWKLateralReusableController>*)toViewController];
        
    }
    
    [self toggleButtons];
    
}

- (void)toggleButtons
{
    
    [[self previousButton] setEnabled:[self currentIndex]>0];
    [[self nextButton] setEnabled:[self currentIndex]<([self numberOfItems])-1];

    
}

- (void)loadChildViewController:(UIViewController<FWKLateralReusableController>*)childViewController
{
    
    NSParameterAssert(childViewController!=nil);
    
    [self addChildViewController:childViewController];
    
    [childViewController prepareForReuse];
    
    [[self controllersContainer] addSubview:[childViewController view]];
    
    [self adjustViewControllerConstraints:childViewController];
    
    [childViewController didMoveToParentViewController:self];
    
}

- (void)flipFromViewController:(UIViewController<FWKLateralReusableController>*)fromViewController
          toViewViewController:(UIViewController<FWKLateralReusableController>*)toViewController
{
    
    [toViewController prepareForReuse];
    [[self controllersContainer] addSubview:[toViewController view]];

    [self adjustViewControllerConstraints:(UIViewController<FWKLateralReusableController>*)toViewController];
    [self adjustViewControllerConstraints:(UIViewController<FWKLateralReusableController>*)fromViewController];

    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:.25
                               options:UIViewAnimationOptionTransitionNone
                            animations:NULL
                            completion:^(BOOL finished) {
                                
                                if ( finished ) {
                                    
                                    [toViewController didMoveToParentViewController:self];
                                    [fromViewController removeFromParentViewController];
                                    [[fromViewController view] removeFromSuperview];
                                    
                                }
                                
                            }];
    
}

- (void)adjustViewControllerConstraints:(UIViewController<FWKLateralReusableController>*)viewController
{
    
    UIView *viewControllerView = [viewController view];
    [viewControllerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIView *superView = [self controllersContainer];
    
    [viewControllerView removeConstraints:[viewControllerView constraints]];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewControllerView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:superView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0.0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:viewControllerView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:superView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:0.0];
    
    NSLayoutConstraint *leadingConstraint = leadingConstraint = [NSLayoutConstraint constraintWithItem:viewControllerView
                                                                                             attribute:NSLayoutAttributeLeading
                                                                                             relatedBy:NSLayoutRelationEqual
                                                                                                toItem:superView
                                                                                             attribute:NSLayoutAttributeLeading
                                                                                            multiplier:1.0
                                                                                              constant:0.0];;
    NSLayoutConstraint *trailingConstraint = trailingConstraint = [NSLayoutConstraint constraintWithItem:viewControllerView
                                                                                               attribute:NSLayoutAttributeTrailing
                                                                                               relatedBy:NSLayoutRelationEqual
                                                                                                  toItem:superView
                                                                                               attribute:NSLayoutAttributeTrailing
                                                                                              multiplier:1.0
                                                                                                constant:0.0];
    
    [superView addConstraints:@[topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]];
    
}

@end
