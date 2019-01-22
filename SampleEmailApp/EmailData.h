//
//  EmailData.h
//  SampleEmailApp
//
//  Created by Prabal on 22/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Email.h"
#import "UserEmail.h"
#import "Draft.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmailData : NSObject

+ (instancetype)getInstance;

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSArray<UserEmail> *inbox;
@property (nonatomic, strong) NSArray<UserEmail> *inboxUnread;
@property (nonatomic, strong) NSArray<Email> *sent;
@property (nonatomic, strong) NSArray<UserEmail> *trash;
@property (nonatomic, strong) NSArray<Draft> *drafts;

- (void)refreshDataFromServer;
@end

NS_ASSUME_NONNULL_END
