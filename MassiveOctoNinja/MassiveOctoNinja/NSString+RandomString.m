//
//  NSString+RandomString.m
//  MassiveOctoNinja
//
//  Created by Ariel Rodriguez on 1/25/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import "NSString+RandomString.h"

NSString *const kChars = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

@implementation NSString (RandomString)
+ (NSString *)randomStringWithLength:(NSUInteger)length {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i=0; i<length; i++) {
        [randomString appendFormat: @"%C", [kChars characterAtIndex: arc4random() % [kChars length]]];
    }
    
    return randomString;
}
@end
