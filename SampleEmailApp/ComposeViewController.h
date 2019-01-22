//
//  ComposeViewController.h
//  SampleEmailApp
//
//  Created by Prabal on 22/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEmail.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController

- (void)configureToReplyToEmail:(UserEmail *)userEmail;

@end

NS_ASSUME_NONNULL_END
