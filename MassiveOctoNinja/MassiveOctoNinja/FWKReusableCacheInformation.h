//
//  FWKReusableCacheInformation.h
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/25/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWKReusableCacheInformation : NSObject
@property (nonatomic, strong) Class controllerClass;
@property (nonatomic, strong) NSMutableArray *cache;
- (BOOL)cacheIsReady;
@end
