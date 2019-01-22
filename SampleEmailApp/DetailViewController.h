//
//  DetailViewController.h
//  SampleEmailApp
//
//  Created by Prabal on 21/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Email.h"
#import "UserEmail.h"
#import "Draft.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *fromEmailId;
@property (weak, nonatomic) IBOutlet UILabel *toEmailIds;
@property (weak, nonatomic) IBOutlet UILabel *subject;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (assign, nonatomic) BOOL isConfigured;

@property (nonatomic, assign) NSInteger category;
@property (nonatomic, strong) NSObject *data;

@end

