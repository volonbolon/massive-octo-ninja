//
//  VBViewController.m
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/23/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import "VBViewController.h"
#import "FWKLateralNavigator.h"
#import "VBLateralViewController.h"
#import "UIColor+RandomColor.h"
#import "NSString+RandomString.h"

NSString *const kControllerIdentifier = @"identifier";

@interface VBViewController ()
@property (strong, nonatomic) NSArray *items;
@end

@implementation VBViewController
- (void)awakeFromNib
{
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:10];
    for ( NSUInteger i = 0; i < 5; i++ ) {
        
        [items addObject:@{@"color": [UIColor randomColor], @"string":[NSString randomStringWithLength:10]}];
        
    }
    
    [self setItems:items];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSLog(@"NSStringFromClass: %@", NSStringFromClass([self class]));
    
    FWKLateralNavigator *ln = [[FWKLateralNavigator alloc] init];
    [ln setDataSource:self];
    [ln registerClass:[VBLateralViewController class]
forControllerWithIdentifier:kControllerIdentifier];
    [self addChildViewController:ln];
    UIView *superView = [self view];
    UIView *lnView = [ln view];
    [superView addSubview:lnView];
    [ln didMoveToParentViewController:self];
    
    [lnView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:lnView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:superView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:20.0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:lnView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:superView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:0.0];
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:lnView
                                                                         attribute:NSLayoutAttributeLeading
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:superView
                                                                         attribute:NSLayoutAttributeLeading
                                                                        multiplier:1.0
                                                                          constant:0.0];
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:lnView
                                                                          attribute:NSLayoutAttributeTrailing
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:superView
                                                                          attribute:NSLayoutAttributeTrailing
                                                                         multiplier:1.0
                                                                           constant:0.0];
    
    [superView addConstraints:@[topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FWKLateralNavigatorDataSource
- (NSInteger)numberOfItemsInLateralNavigator:(FWKLateralNavigator *)lateralNavigator
{
    
    return (NSInteger)[[self items] count];
    
}

- (UIViewController <FWKLateralReusableController>*)lateralNavigator:(FWKLateralNavigator *)lateralNavigator
                                               viewControllerForIndex:(NSUInteger)index
{
    
    VBLateralViewController *vc = (VBLateralViewController *)[lateralNavigator dequeueReusableControllerWithIdentifier:kControllerIdentifier];
    
    NSDictionary *item = [[self items] objectAtIndex:index];
    
    [[vc view] setBackgroundColor:[item objectForKey:@"color"]];
    [[vc label] setText:[item objectForKey:@"string"]];
    
    return (UIViewController <FWKLateralReusableController>*)vc;
    
}

@end
