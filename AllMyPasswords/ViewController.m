//
//  ViewController.m
//  AllMyPasswords
//
//  Created by Mahaboobsab Nadaf on 14/10/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self performSegueWithIdentifier:@"passwords" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)authenticateButtonTapped:(id)sender {
    
    
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"Are you the device owner?"
                          reply:^(BOOL success, NSError *error) {
                              
                              if (error) {
                                  
                                  
                                  
                                  
                                  
                                  UIAlertController* alert1 = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                  message:@"There was a problem verifying your identity."
                                                                                           preferredStyle:UIAlertControllerStyleAlert];
                                  
                                  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                        handler:^(UIAlertAction * action) {}];
                                  
                                  [alert1 addAction:defaultAction];
                                  [self presentViewController:alert1 animated:YES completion:nil];
                                  
                                  
                                  return;
                              }
                              
                              if (success) {
                                  
                                  
                                  UIAlertController* alert1 = [UIAlertController alertControllerWithTitle:@"Success"
                                                                                                  message:@"You are the device owner!"
                                                                                           preferredStyle:UIAlertControllerStyleAlert];
                                  
                                  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                        handler:^(UIAlertAction * action) {
                                                                                        
                                                                                        
                                                                                        [self performSegueWithIdentifier:@"passwords" sender:self];}];
                                  
                                  [alert1 addAction:defaultAction];
                                  [self presentViewController:alert1 animated:YES completion:nil];
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                              } else {
                                  
                                  
                                  
                                  
                                  
                                  
                                  UIAlertController* alert1 = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                  message:@"You are not the device owner."
                                                                                           preferredStyle:UIAlertControllerStyleAlert];
                                  
                                  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                        handler:^(UIAlertAction * action) {}];
                                  
                                  [alert1 addAction:defaultAction];
                                  [self presentViewController:alert1 animated:YES completion:nil];
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                              }
                              
                          }];
        
    } else {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Your device cannot authenticate using TouchID."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

@end
