//
//  Email.h
//  SampleEmailApp
//
//  Created by Prabal on 22/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import "JSONModel.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Email
@end

@interface Email : JSONModel
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) User *fromEmail;
@property (nonatomic, strong) NSArray<User> *toEmails;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) Email<Optional> *parentEmail;

- (NSString *)getFullEmailBodyWithChain;
@end

NS_ASSUME_NONNULL_END
