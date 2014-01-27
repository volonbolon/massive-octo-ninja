//
//  FWKReusableCacheInformation.m
//
//  Created by Ariel Rodriguez on 1/25/14.
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
