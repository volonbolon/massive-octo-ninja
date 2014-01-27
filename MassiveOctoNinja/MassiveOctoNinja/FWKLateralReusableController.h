//
//  FWKLateralReusableController.h
//
//  Created by Ariel Rodriguez on 1/25/14.
//

#import <Foundation/Foundation.h>

/**
 Protocol that all the controllers used in the lateral navigator needs to implement.
 */
@protocol FWKLateralReusableController <NSObject>
@required
/**
 We save the identifier associated with the controller class to perform some instrospection
 */
@property (nonatomic, strong) NSString *identifier;

/**
 Called right before adding the view to the container view. Clients should clean pictures and make sure the controller is ready to be reused after returning from this method.
 */
@required
- (void)prepareForReuse;
@end
