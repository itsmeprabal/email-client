//
//  EmailData.m
//  SampleEmailApp
//
//  Created by Prabal on 22/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import "EmailData.h"
#import "JSONModel+Subclass.h"

@implementation EmailData

+ (instancetype)getInstance {
    static EmailData *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[EmailData alloc] init];
    });
    return data;
}

- (void)refreshDataFromServer {
    NSString *authToken = self.authToken;
    [self fetchInbox:authToken];
    [self fetchUnreadInbox:authToken];
    [self fetchSent:authToken];
    [self fetchTrash:authToken];
    [self fetchDrafts:authToken];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"");
    });
}

- (void)fetchInbox:(NSString *)authToken {
    NSString *inboxUrl = [NSString stringWithFormat:@"http://localhost:9000/emails/inbox/all/user/%@/page/%@", self.email, @"1"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:inboxUrl]];
    
    //create the Method "GET" or "POST"
    [urlRequest setHTTPMethod:@"GET"];
    
    //header
    [urlRequest addValue:authToken forHTTPHeaderField:@"X-AUTH-TOKEN-KEY"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSArray *inboxArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            self.inbox = [UserEmail arrayOfModelsFromDictionaries:inboxArray error:&error];
        }
        else
        {
            NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

- (void)fetchSent:(NSString *)authToken {
    NSString *inboxUrl = [NSString stringWithFormat:@"http://localhost:9000/emails/sent/user/%@/page/%@", self.email, @"1"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:inboxUrl]];
    
    //create the Method "GET" or "POST"
    [urlRequest setHTTPMethod:@"GET"];
    
    //header
    [urlRequest addValue:authToken forHTTPHeaderField:@"X-AUTH-TOKEN-KEY"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSArray *inboxArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            self.sent = [Email arrayOfModelsFromDictionaries:inboxArray error:&error];
        }
        else
        {
            NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

- (void)fetchDrafts:(NSString *)authToken {
    NSString *inboxUrl = [NSString stringWithFormat:@"http://localhost:9000/emails/drafts/user/%@/page/%@", self.email, @"1"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:inboxUrl]];
    
    //create the Method "GET" or "POST"
    [urlRequest setHTTPMethod:@"GET"];
    
    //header
    [urlRequest addValue:authToken forHTTPHeaderField:@"X-AUTH-TOKEN-KEY"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSArray *inboxArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            self.drafts = [Draft arrayOfModelsFromDictionaries:inboxArray error:&error];
        }
        else
        {
            NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

- (void)fetchUnreadInbox:(NSString *)authToken {
    NSString *inboxUrl = [NSString stringWithFormat:@"http://localhost:9000/emails/inbox/unread/user/%@/page/%@", self.email, @"1"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:inboxUrl]];
    
    //create the Method "GET" or "POST"
    [urlRequest setHTTPMethod:@"GET"];
    
    //header
    [urlRequest addValue:authToken forHTTPHeaderField:@"X-AUTH-TOKEN-KEY"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSArray *inboxArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            self.inboxUnread = [UserEmail arrayOfModelsFromDictionaries:inboxArray error:&error];
        }
        else
        {
            NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

- (void)fetchTrash:(NSString *)authToken {
    NSString *inboxUrl = [NSString stringWithFormat:@"http://localhost:9000/emails/trash/user/%@/page/%@", self.email, @"1"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:inboxUrl]];
    
    //create the Method "GET" or "POST"
    [urlRequest setHTTPMethod:@"GET"];
    
    //header
    [urlRequest addValue:authToken forHTTPHeaderField:@"X-AUTH-TOKEN-KEY"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSArray *inboxArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            self.trash = [UserEmail arrayOfModelsFromDictionaries:inboxArray error:&error];
        }
        else
        {
            NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

@end
