//
//  DetailViewController.m
//  SampleEmailApp
//
//  Created by Prabal on 21/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import "DetailViewController.h"
#import "User.h"
#import "EmailData.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (self.data) {
        [self configure];
    }
}

- (void)configure {
    switch (self.category) {
        case 0:
            [self configureInboxItem:(UserEmail *)self.data];
            break;
            
        case 1:
            [self configureSentItem:(Email *)self.data];
            break;
            
        case 2:
            [self configureDraftItem:(Draft *)self.data];
            break;
            
        case 3:
            [self configureTrashItem:(UserEmail *)self.data];
            break;
            
        default:
            break;
    }
}

- (void)configureWithEmail:(Email *)email {
    self.fromEmailId.text = email.fromEmail.email;
    
    __block NSString *to = @"";
    [email.toEmails enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        to = [to stringByAppendingString:((User *)obj).email];
        to = [to stringByAppendingString:@","];
    }];
    self.toEmailIds.text = to;
    
    self.subject.text = email.subject;
    
    self.body.text = [email getFullEmailBodyWithChain];
}

- (void)configureInboxItem:(UserEmail *)inboxEmail {
    if ([inboxEmail.readState isEqualToString:@"UNREAD"]) {
        self.type.text = @"Unread Email";
    } else {
        self.type.text = @"Read Email";
    }
    [self configureWithEmail:inboxEmail.email];
    
    self.isConfigured = YES;
}

- (void)configureSentItem:(Email *)sentEmail {
    self.type.text = @"Sent";
    [self configureWithEmail:sentEmail];
    self.isConfigured = YES;
}

- (void)configureTrashItem:(UserEmail *)trashEmail {
    self.type.text = @"Trash";
    [self configureWithEmail:trashEmail.email];
    self.isConfigured = YES;
}

- (void)configureDraftItem:(Draft *)draft {
    self.type.text = @"Draft";
    
    self.fromEmailId.text = [EmailData getInstance].email;
    
    self.toEmailIds.text = draft.toEmails;
    
    self.subject.text = draft.subject;
    
    self.body.text = draft.body;
    self.isConfigured = YES;
}

@end
