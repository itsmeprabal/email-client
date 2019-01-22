//
//  User.h
//  SampleEmailApp
//
//  Created by Prabal on 22/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol User
@end

@interface User : JSONModel
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *name;
@end

NS_ASSUME_NONNULL_END
