//
//  FWKLateralNavigator_Private.h
//
//  Created by Ariel Rodriguez on 1/25/14.
//

#import "FWKLateralNavigator.h"
#import "FWKLateralReusableController.h"
#import "FWKLateralNavigatorDataSource.h"

@interface FWKLateralNavigator ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (nonatomic, strong) UINavigationController *parentNavigationController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousButton;
@property (nonatomic, assign) NSUInteger numberOfItems;
@property (nonatomic, strong) NSMutableDictionary *cache;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (weak, nonatomic) IBOutlet UIView *controllersContainer;

- (IBAction)previousButtonTapped:(id)sender;
- (IBAction)nextButtonTapped:(id)sender;

- (void)loadChildViewController:(UIViewController<FWKLateralReusableController>*)childViewController;

- (void)flipFromViewController:(UIViewController<FWKLateralReusableController>*)fromViewController
          toViewViewController:(UIViewController<FWKLateralReusableController>*)toViewController;

- (void)adjustViewControllerConstraints:(UIViewController<FWKLateralReusableController>*)viewController;

- (void)toggleButtons;

@end