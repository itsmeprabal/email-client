//
//  SplitViewDelegate.h
//  SampleEmailApp
//
//  Created by Prabal on 22/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SplitViewDelegate : NSObject <UISplitViewControllerDelegate>

+ (instancetype)sharedDelegate;

@end

NS_ASSUME_NONNULL_END
