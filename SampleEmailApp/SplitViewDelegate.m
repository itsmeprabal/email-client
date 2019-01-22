//
//  SplitViewDelegate.m
//  SampleEmailApp
//
//  Created by Prabal on 22/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import "SplitViewDelegate.h"
#import "DetailViewController.h"

@implementation SplitViewDelegate

+ (instancetype)sharedDelegate {
    static SplitViewDelegate *delegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        delegate = [[SplitViewDelegate alloc] init];
    });
    return delegate;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && !([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] isConfigured])) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

@end
