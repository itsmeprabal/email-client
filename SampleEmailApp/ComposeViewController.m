//
//  ComposeViewController.m
//  SampleEmailApp
//
//  Created by Prabal on 22/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import "ComposeViewController.h"
#import "EmailData.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *toField;
@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)saveDraft:(id)sender {
    NSString *to = _toField.text;
    NSString *subject = _subjectField.text;
    NSString *body = _bodyTextView.text;
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost:9000/emails/saveDraft"]];
    
    NSDictionary *paramsDict = [NSDictionary dictionaryWithObjectsAndKeys:[EmailData getInstance].email, @"emailSender", to, @"emailRecepients", subject, @"emailSubject", body, @"emailBody", nil];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramsDict options:0 error:&error];
    if (error) {
        
    }
    
    //create the Method "GET" or "POST"
    [urlRequest setHTTPMethod:@"POST"];
    
    //Convert the String to Data
    NSData *data1 = jsonData;
    
    //Apply the data to the body
    [urlRequest setHTTPBody:data1];
    
    //header
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:[EmailData getInstance].authToken forHTTPHeaderField:@"X-AUTH-TOKEN-KEY"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
            
            [self showAlertWithTitle:@"Draft Saved" andSubtitle:@"Draft has been saved"];
        }
        else
        {
            [self showAlertWithTitle:@"Draft Failed" andSubtitle:@"Check all fields"];
        }
    }];
    [dataTask resume];
}

- (IBAction)sendEmail:(id)sender {
    NSString *to = _toField.text;
    NSString *subject = _subjectField.text;
    NSString *body = _bodyTextView.text;
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost:9000/emails/send"]];
    
    NSDictionary *paramsDict = [NSDictionary dictionaryWithObjectsAndKeys:[EmailData getInstance].email, @"emailSender", to, @"emailRecepients", subject, @"emailSubject", body, @"emailBody", nil];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramsDict options:0 error:&error];
    if (error) {
        
    }
    
    //create the Method "GET" or "POST"
    [urlRequest setHTTPMethod:@"POST"];
    
    //Convert the String to Data
    NSData *data1 = jsonData;
    
    //Apply the data to the body
    [urlRequest setHTTPBody:data1];
    
    //header
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:[EmailData getInstance].authToken forHTTPHeaderField:@"X-AUTH-TOKEN-KEY"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
            
            [self showAlertWithTitle:@"Email Sent" andSubtitle:@"Email has been sent"];
        }
        else
        {
            [self showAlertWithTitle:@"Draft Failed" andSubtitle:@"Check all fields"];
        }
    }];
    [dataTask resume];
}

- (void)showAlertWithTitle:(NSString *)title andSubtitle:(NSString *)subtitle {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:subtitle
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

@end
