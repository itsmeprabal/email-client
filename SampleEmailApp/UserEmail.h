//
//  UserEmail.h
//  SampleEmailApp
//
//  Created by Prabal on 22/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import "JSONModel.h"
#import "User.h"
#import "Email.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UserEmail
@end

@interface UserEmail : JSONModel
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) User *userEmail;
@property (nonatomic, strong) Email *email;
@property (nonatomic, strong) NSString *readState;
@property (nonatomic, assign) BOOL deleted;
@end

NS_ASSUME_NONNULL_END
