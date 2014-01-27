//
//  FWKReusableCacheInformation.h
//
//  Created by Ariel Rodriguez on 1/25/14.
//

#import <Foundation/Foundation.h>

/**
 Used internally to save information about the classes that are registered for the lateral navigator controller. 
 This is just a convenience class, and since it is only a matter of implementation, should be treated as private.
 */
@interface FWKReusableCacheInformation : NSObject
@property (nonatomic, strong) Class controllerClass;
@property (nonatomic, strong) NSMutableArray *cache;
- (BOOL)cacheIsReady;
@end
