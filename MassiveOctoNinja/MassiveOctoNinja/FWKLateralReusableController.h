//
//  FWKLateralReusableController.h
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/25/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FWKLateralReusableController <NSObject>
@required
@property (nonatomic, strong) NSString *identifier;

@required
- (void)prepareForReuse;
@end
