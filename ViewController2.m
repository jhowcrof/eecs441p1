//
//  ViewController2.m
//  EECS441P1
//
//  Created by Jacob Howcroft on 9/11/13.
//  Copyright (c) 2013 Jacob Howcroft. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()
- (IBAction)createGroupClick:(id)sender;
- (IBAction)joinGroupClicked:(id)sender;

@end

@implementation ViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Initialize the CollabrifyClient
    if ([self client]) NSLog(@"Client already initialized");
    NSError *error;
    [self setClient:[[CollabrifyClient alloc] initWithGmail:@"usersGmail@gmail.com"
                                                displayName:@"User's Display Name"
                                               accountGmail:@"441fall2013@umich.edu"
                                                accessToken:@"XY3721425NoScOpE"
                                             getLatestEvent:NO
                                                      error:&error]];
    
    [self setTags:@[@"jhjk"]];
    [[self client] setDelegate:self];
    [[self client] setDataSource:self];
    
    if (error) {
        NSLog(@"error!!!!");
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)joinSession:(NSString *)password {
    [[self client] joinSessionWithID:[self session].sessionID password:password completionHandler:^(int64_t maxOrderID, int32_t baseFileSize, CollabrifyError *error) {
        if([error type] == CollabrifyServerSideErrorInvalidSessionPassword){
            UIAlertView *passwordInvalidError = [[UIAlertView alloc] initWithTitle:@"Invalid Password" message:@"The password you have entered invalid" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [passwordInvalidError show];
        } else {
            [self performSegueWithIdentifier:@"VC2toVC" sender:self];
        }
        
    }];
}

- (IBAction)createGroupClick:(id)sender {
    // 1: Check if the device can connect to the internet
    if (![CollabrifyClient hasNetworkConnection]) {
        UIAlertView *networkAlert = [[UIAlertView alloc]
                                     initWithTitle:@"Cannot Access Internet"
                                     message:@"Please check your connection and try again."
                                     delegate:nil
                                     cancelButtonTitle:@"Okay"
                                     otherButtonTitles:nil, nil];
        [networkAlert show];
        return;
    }
    
    // 2: Ask if group is password protected or not
    UIAlertView *passwordAlert = [[UIAlertView alloc]
                                  initWithTitle:@"Select a Configuration"
                                  message:@"Would you like to password protect access to your group?"
                                  delegate:self
                                  cancelButtonTitle:@"Yes"
                                  otherButtonTitles:@"No", nil];
    [passwordAlert show];
    
    // 4: When the alert closes, save the string, open a new session and navigate to ViewController
    // This step will take place in the alertView clickedButtonAtIndex function.
    
}

// Display an error when a required field is blank
-(void)displayBlankError:(NSString *)message{
    UIAlertView *blankError = [[UIAlertView alloc]
                               initWithTitle:@"Error: Blank Fields"
                               message:message
                               delegate:self
                               cancelButtonTitle:@"Okay"
                               otherButtonTitles:nil, nil];
    
    [blankError show];
}

- (IBAction)joinGroupClicked:(id)sender {
    // 1: Check if the device can connect to the internet
    if (![CollabrifyClient hasNetworkConnection]) {
        UIAlertView *networkAlert = [[UIAlertView alloc]
                                     initWithTitle:@"Cannot Access Internet"
                                     message:@"Please check your connection and try again."
                                     delegate:nil
                                     cancelButtonTitle:@"Okay"
                                     otherButtonTitles:nil, nil];
        [networkAlert show];
        return;
    }
    
    // 2: Pop up a box to enter session name
    UIAlertView *joinGroupAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Enter the Group Name"
                                   message:@"Please enter the name of the group you wish to join."
                                   delegate:self
                                   cancelButtonTitle:@"Join"
                                   otherButtonTitles:@"Cancel", nil];
    [joinGroupAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *joinGroupAlertTextField = [joinGroupAlert textFieldAtIndex:0];
    joinGroupAlertTextField.placeholder = @"Group Name";
    
    [joinGroupAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.title isEqual:@"Select a Configuration"]) {
        if (buttonIndex == 0) {
            UIAlertView *groupNameAlert = [[UIAlertView alloc]
                                           initWithTitle:@"Enter a Group Name and Password"
                                           message:@"Please enter a name for your group and a access password."
                                           delegate:self
                                           cancelButtonTitle:@"Done"
                                           otherButtonTitles:@"Cancel", nil];
            groupNameAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            UITextField *groupNameAlertTextField = [groupNameAlert textFieldAtIndex:0];
            UITextField *groupPasswordTextField = [groupNameAlert textFieldAtIndex:1];
            groupNameAlertTextField.placeholder = @"Group Name";
            groupPasswordTextField.placeholder = @"Password";
            [groupNameAlert show];
        } else {
            UIAlertView *groupNameAlert = [[UIAlertView alloc]
                                           initWithTitle:@"Enter a Group Name"
                                           message:@"Please enter a name for your group."
                                           delegate:self
                                           cancelButtonTitle:@"Done"
                                           otherButtonTitles:@"Cancel", nil];
            groupNameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *groupNameAlertTextField = [groupNameAlert textFieldAtIndex:0];
            groupNameAlertTextField.placeholder = @"Group Name";
            [groupNameAlert show];
        }

    } else if ([alertView.title isEqual:@"Enter a Group Name and Password"]) {
        // 1: Make sure password and group name are not blank
        if (buttonIndex != 0) return;
        NSString *groupName = [alertView textFieldAtIndex:0].text;
        NSString *password = [alertView textFieldAtIndex:1].text;
        if ([groupName  isEqual: @""] || [password isEqual:@""]){
            [self displayBlankError:@"Please do not leave any fields blank. Enter a group name and password."];
        } else {
            // 2: Create new session with given strings
            NSLog(@"Before create session");
            [[self client] listSessionsWithTags:@[@"jhjk"]
                              completionHandler:^(NSArray *sessionList, CollabrifyError *error) {
                                  NSUInteger result = [sessionList indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop){
                                      CollabrifySession* sesh = obj;
                                      if ([sesh.sessionName isEqualToString:groupName]) {
                                          NSLog(@"FOUND!!!!!!!!");
                                          *stop = YES;
                                          return YES;
                                      } else return NO;
                                  }];
                                  
                                
                                  if (result != NSNotFound) {
                                      UIAlertView *sessionPresentError = [[UIAlertView alloc] initWithTitle:@"Group Name Already In Use" message:@"Please provide a different group name." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                                      [sessionPresentError show];
                                  } else {
                                          
                                          [[self client] createSessionWithBaseFileWithName:groupName
                                                                                      tags:[self tags]
                                                                                  password:password
                                                                          participantLimit:500
                                                                               startPaused:YES
                                                                         completionHandler:^(int64_t sessionID, CollabrifyError *error) {
                                                                             NSLog(@"In completion handler");
                                                                             
                                                                             if (error) {
                                                                                 // Do something
                                                                                 NSLog(@"Error");
                                                                             } else {
                                                                                 // 3: Join session on success
                                                                                 
                                                                                 [[self client] joinSessionWithID:sessionID password:password completionHandler:^(int64_t maxOrderID, int32_t baseFileSize, CollabrifyError *error) {
                                                                                     if (error) {
                                                                                         NSLog(@"Error: %@", [error class]);
                                                                                     } else {
                                                                                         NSLog(@"SEGUE to new VC");
                                                                                         [self performSegueWithIdentifier:@"VC2toVC" sender:self];
                                                                                     }
                                                                                 }];
                                                                             }
                                                                         }];

                                      
                                  }
                                  
                              }];
            NSLog(@"Does this happen");
            
        }
    } else if ([alertView.title isEqual:@"Enter a Group Name"]){
        // 1: Make sure group name is not blank
        if (buttonIndex != 0) return;
        NSString *groupName = [alertView textFieldAtIndex:0].text;
        if([groupName isEqual: @""]){
            [self displayBlankError:@"Please do not leave any fields blank. Enter a group name."];
        } else {
            // 2: Create new session with given strings
            NSLog(@"Before create session");
            [[self client] listSessionsWithTags:@[@"jhjk"]
                              completionHandler:^(NSArray *sessionList, CollabrifyError *error) {
                                  NSUInteger result = [sessionList indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop){
                                      CollabrifySession* sesh = obj;
                                      if ([sesh.sessionName isEqualToString:groupName]) {
                                          NSLog(@"FOUND!!!!!!!!");
                                          *stop = YES;
                                          return YES;
                                      } else return NO;
                                  }];
                                  
                                  
                                  if (result != NSNotFound) {
                                      UIAlertView *sessionPresentError = [[UIAlertView alloc] initWithTitle:@"Group Name Already In Use"
                                                                                                    message:@"Please provide a different group name."
                                                                                                   delegate:self
                                                                                          cancelButtonTitle:@"Okay"
                                                                                          otherButtonTitles:nil, nil];
                                      [sessionPresentError show];
                                      NSLog(@"Gets to the found block");
                                  } else {
                                      NSLog(@"Gets to the NOT found block");
                                      [[self client] createSessionWithBaseFileWithName:groupName
                                                                                  tags:[self tags]
                                                                              password:nil
                                                                      participantLimit:500
                                                                           startPaused:YES
                                                                     completionHandler:^(int64_t sessionID, CollabrifyError *error) {
                                                                         NSLog(@"In completion handler");
                                                                         
                                                                         if (error) {
                                                                             NSLog(@"ERROR for create session");
                                                                         } else {
                                                                             // 3: Join session on success
                                                                             
                                                                             //[[self client] joinSessionWithID:sessionID password:@"" completionHandler:^(int64_t maxOrderID, int32_t baseFileSize, CollabrifyError *error) {
                                                                                 //if (error) {
                                                                                   //  NSLog(@"Error: %@", [error class]);
                                                                                 //} else {
                                                                                     NSLog(@"SEGUE to new VC");
                                                                                     [self performSegueWithIdentifier:@"VC2toVC" sender:self];
                                                                                 //}
                                                                             //}];
                                                                         }
                                                                     }];
                                  }
                              }];
             
            
            
            NSLog(@"Does this happen");

            // 3: Segue on success
            //[self performSegueWithIdentifier:@"VC2toVC" sender:self];

        }
    
    // If there is a blank field
    } else if ([alertView.title isEqual:@"Error: Blank Fields"]){
        UIAlertView *groupNameAlert;
        // If it is for create group with password
        if ([alertView.message isEqual:@"Please do not leave any fields blank. Enter a group name and password."]){
            groupNameAlert = [[UIAlertView alloc]
                                           initWithTitle:@"Enter a Group Name and Password"
                                           message:@"Please enter a name for your group and an access password."
                                           delegate:self
                                           cancelButtonTitle:@"Done"
                                           otherButtonTitles:@"Cancel", nil];
            
            groupNameAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            UITextField *groupNameAlertTextField = [groupNameAlert textFieldAtIndex:0];
            UITextField *groupPasswordTextField = [groupNameAlert textFieldAtIndex:1];
            groupNameAlertTextField.placeholder = @"Group Name";
            groupPasswordTextField.placeholder = @"Password";
            [groupNameAlert show];
            
        // If it is for group without password
        } else {
            groupNameAlert = [[UIAlertView alloc]
                                           initWithTitle:@"Enter a Group Name"
                                                message:@"Please enter a name for your group."
                                                delegate:self
                                           cancelButtonTitle:@"Done"
                                           otherButtonTitles:@"Cancel", nil];
            
            groupNameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *groupNameAlertTextField = [groupNameAlert textFieldAtIndex:0];
            groupNameAlertTextField.placeholder = @"Group Name";
            [groupNameAlert show];
        }
    } else if ([alertView.title isEqual:@"Enter the Group Name"]) {
        if (buttonIndex != 0) return;
        NSString *response = [alertView textFieldAtIndex:0].text;
        [[self client] listSessionsWithTags:@[@"jhjk"]
                          completionHandler:^(NSArray *sessionList, CollabrifyError *error) {
                                NSUInteger result = [sessionList indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop){
                                    CollabrifySession* sesh = obj;
                                    if ([sesh.sessionName isEqualToString:response]) {
                                        NSLog(@"FOUND!!!!!!!!");
                                        *stop = YES;
                                        return YES;
                                    } else return NO;
                                }];
                              
                              if (result != NSNotFound) {
                                  NSLog(@"Found session with name %@.  Session index is %d", response, result);
                                  [self setSession:sessionList[result]];
                                  if ([[self session] isPasswordProtected]) {
                                      UIAlertView *joinSessionWithPassword = [[UIAlertView alloc] initWithTitle:@"Enter Group Password"
                                                                                                        message:@"Please enter the password for the group."
                                                                                                       delegate:self
                                                                                              cancelButtonTitle:@"Join"
                                                                                              otherButtonTitles:@"Cancel", nil];
                                      
                                      [joinSessionWithPassword setAlertViewStyle:UIAlertViewStyleSecureTextInput];
                                      UITextField *passwordField = [joinSessionWithPassword textFieldAtIndex:0];
                                      passwordField.placeholder = @"Group Password";
                                      [joinSessionWithPassword show];
                                  } else {
                                      [self joinSession:@""];
                                  }
                              } else {
                                  UIAlertView *sessionNotFound = [[UIAlertView alloc] initWithTitle:@"Group Not Found"
                                                                                            message:@"This group has not been created."
                                                                                           delegate:self
                                                                                  cancelButtonTitle:@"Okay"
                                                                                  otherButtonTitles:nil, nil];
                                  [sessionNotFound show];
                              }
                              
                              
                          }];
    } else if ([alertView.title isEqual:@"Enter Group Password"]) {
        NSString *password = [alertView textFieldAtIndex:0].text;
        [self joinSession:password];
    }
}



-(NSData *)client:(CollabrifyClient *)client requestsBaseFileChunkForCurrentBaseFileSize:(NSInteger)baseFileSize{
    if (![self data]) {
        NSString *stringdata = @"TEST";
        [self setData:[stringdata dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSInteger length = [[self data] length] - baseFileSize;
    
    if (length == 0) {
        return nil;
    }
    
    return [NSData dataWithBytes:([[self data] bytes] + baseFileSize) length:length];
}

// Transfer the client and other information to the next ViewController on segue.
// Got this function from Matt Price on stackoverflow: http://stackoverflow.com/a/9736559/2390856
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"VC2toVC"]){
        NSLog(@"passing client to new VC");
        ViewController *controller = (ViewController *)segue.destinationViewController;
        controller.client = [self client];
        controller.tags = [self tags];
        controller.session = [self session];
    }
}

@end
