//
//  VBLateralViewController.h
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/25/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWKLateralReusableController.h"

@interface VBLateralViewController : UIViewController <FWKLateralReusableController>
@property (nonatomic, strong) NSString *identifier;
@end
