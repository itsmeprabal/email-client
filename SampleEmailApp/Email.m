//
//  Email.m
//  SampleEmailApp
//
//  Created by Prabal on 22/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import "Email.h"

@implementation Email

- (NSString *)getFullEmailBodyWithChain {
    NSMutableString *bodyString = [self.body mutableCopy];
    if (!self.parentEmail) {
        return [NSString stringWithString:bodyString];
    }
    Email *next = self.parentEmail;
    [bodyString appendFormat:@"\n \n------- Replying To ------- \n \n%@", [next getFullEmailBodyWithChain]];
    return [NSString stringWithString:bodyString];
}

@end
