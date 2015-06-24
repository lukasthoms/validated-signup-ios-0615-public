//
//  FISViewController.m
//  validatedSignUp
//
//  Created by Joe Burgess on 7/2/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

- (BOOL)validateEmailWithString:(NSString*)email;

@end

@implementation FISViewController

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //create UIAlert
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Invalid Input" message:@"Please don't use digits." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *clearAction = [UIAlertAction actionWithTitle:@"Clear" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        textField.text = @"";
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"PRessed ok");
    }];
    [alertController addAction:clearAction];
    [alertController addAction:okAction];
    
    // create character set that doesn't have digits
    NSCharacterSet *digits = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"] invertedSet];
    
    
    if ([textField isEqual:self.firstName] || [textField isEqual:self.lastName] || [textField isEqual:self.userName]) {
        if (textField.text.length > 0 && [textField.text rangeOfCharacterFromSet:digits].location == NSNotFound) {
            [self advanceToNextTextField:textField];
        } else {
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
    } else if ([textField isEqual:self.email]) {
        if (textField.text.length > 0 && [self validateEmailWithString:textField.text]) {
            [self advanceToNextTextField:textField];
        } else {
            
            alertController.message = @"Please enter a valid email.";
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } else if ([textField isEqual:self.password]) {
        if (textField.text.length > 6) {
            [self.submitButton setEnabled:YES];
            [textField resignFirstResponder];
        } else {
            alertController.message = @"Please use more than 6 characters.";
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }

    return YES;
}

-(void) advanceToNextTextField: (UITextField *)textField {
    NSArray *textFieldArray = @[self.firstName, self.lastName, self.email, self.userName, self.password];
    [textFieldArray[[textFieldArray indexOfObject:textField]+1]setEnabled:YES];
    [textField setEnabled:NO];
    [textFieldArray[[textFieldArray indexOfObject:textField]+1] becomeFirstResponder];
    
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.email.delegate = self;
    self.userName.delegate = self;
    self.password.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
