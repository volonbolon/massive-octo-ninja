//
//  FWKReusableCacheInformation.m
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/25/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import "FWKReusableCacheInformation.h"

static const NSUInteger kMaximumberOfItemsInCache = 3;

@implementation FWKReusableCacheInformation
- (BOOL)cacheIsReady
{
    
    NSUInteger numberOfItemsInCache = [[self cache] count];
    return numberOfItemsInCache == kMaximumberOfItemsInCache;
    
}
@end
