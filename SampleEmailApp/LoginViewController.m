//
//  LoginViewController.m
//  SampleEmailApp
//
//  Created by Prabal on 21/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import "LoginViewController.h"
#import "EmailData.h"
#import "SplitViewDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *savedEmail = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_email"];
    NSString *savedPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_password"];
    
    if (savedEmail && savedEmail.length>0 && savedPassword && savedPassword.length > 0) {
        self.emailField.text = savedEmail;
        self.passwordField.text = savedPassword;
    }
}

- (IBAction)onLoginTapped:(id)sender {
    NSString *email = _emailField.text;
    NSString *password = _passwordField.text;
    
    [EmailData getInstance].email = email;
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost:9000/login"]];
    
    NSDictionary *paramsDict = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password, @"password", nil];
    
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
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
            
            NSString *authToken = [responseDictionary valueForKey:@"authToken"];
            if (authToken) {
                //successful login
                [EmailData getInstance].authToken = authToken;
                [[EmailData getInstance] refreshDataFromServer];
                
                [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"user_email"];
                [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"user_password"];
            }
            
        }
        else
        {
            NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"login_to_master"]) {
        UISplitViewController *splitViewController = (UISplitViewController *)segue.destinationViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
        splitViewController.delegate = [SplitViewDelegate sharedDelegate];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
