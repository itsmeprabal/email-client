//
//  Draft.h
//  SampleEmailApp
//
//  Created by Prabal on 22/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import "JSONModel.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Draft
@end

@interface Draft : JSONModel
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) User *fromEmail;
@property (nonatomic, strong) NSString<Optional> *toEmails;
@property (nonatomic, strong) NSString<Optional> *subject;
@property (nonatomic, strong) NSString<Optional> *body;
@end

NS_ASSUME_NONNULL_END
