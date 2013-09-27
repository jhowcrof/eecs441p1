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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createGroupClick:(id)sender {
    // 1: Check if the device can connect to the internet
    if (![CollabrifyClient hasNetworkConnection]) {
        UIAlertView *networkAlert = [[UIAlertView alloc] initWithTitle:@"Cannot Access Internet" message:@"Please check your connection and try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [networkAlert show];
        return;
    }
    
    // 2: Ask if group is password protected or not
    UIAlertView *passwordAlert = [[UIAlertView alloc] initWithTitle:@"Select a Configuration" message:@"Would you like to password protect access to your group?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [passwordAlert show];
    
    // 4: When the alert closes, save the string, open a new session and navigate to ViewController
    
}

- (IBAction)joinGroupClicked:(id)sender {
    // 1: Check if the device can connect to the internet
    if (![CollabrifyClient hasNetworkConnection]) {
        UIAlertView *networkAlert = [[UIAlertView alloc] initWithTitle:@"Cannot Access Internet" message:@"Please check your connection and try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [networkAlert show];
        return;
    }
    
    // 2: Navigate to a new page
    // 2: Make a list of all available groups
    //CollabrifyClient *collabrifyclient = [CollabrifyClient alloc];
    //NSArray *sessionTagArray;
    //NSArray *sessionList;
    //CollabrifyError *sessionListError;
    //[collabrifyclient listSessionsWithTags:sessionTagArray completionHandler:(sessionList, nil)];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([alertView.title  isEqual: @"Select a Configuration"]){
        if(buttonIndex == 0){
            UIAlertView *groupNameAlert = [[UIAlertView alloc] initWithTitle:@"Enter a Group Name and Password" message:@"Please enter a name for your group and a access password." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
            groupNameAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            UITextField *groupNameAlertTextField = [groupNameAlert textFieldAtIndex:0];
            UITextField *groupPasswordTextField = [groupNameAlert textFieldAtIndex:1];
            groupNameAlertTextField.placeholder = @"Group Name";
            groupPasswordTextField.placeholder = @"Password";
            [groupNameAlert show];
        }
        else{
            UIAlertView *groupNameAlert = [[UIAlertView alloc] initWithTitle:@"Enter a Group Name" message:@"Please enter a name for your group." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
            groupNameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *groupNameAlertTextField = [groupNameAlert textFieldAtIndex:0];
            groupNameAlertTextField.placeholder = @"Group Name";
            [groupNameAlert show];
        }

    }
    else if([alertView.title isEqual:@"Enter a Group Name and Password"]){
        // 1: Make sure password and group name are not blank
        UITextField *groupNameUITF = [alertView textFieldAtIndex:0];
        UITextField *passwordUITF = [alertView textFieldAtIndex:1];
        if([groupNameUITF.text  isEqual: @""] || [passwordUITF.text isEqual:@""]){
            UIAlertView *blankError = [[UIAlertView alloc] initWithTitle:@"Error: Blank Fields" message:@"Please do not leave any fields blank. Enter a group name and password." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [blankError show];
        }
        else{
            
            // 2: Create new group with given strings
            CollabrifyClient *clientX = [[CollabrifyClient alloc] init];
            int64_t *sessionID;
            CollabrifyError *errorReturned;
            [clientX createSessionWithBaseFileWithName:groupNameUITF.text tags:nil password:passwordUITF.text participantLimit:500 startPaused:true completionHandler:<#^(int64_t sessionID, CollabrifyError *error)completionHandler#>]
            
            // 3: Segue on success
            [self performSegueWithIdentifier:@"VC2toVC" sender:self];
        }
    }
    else if([alertView.title isEqual:@"Enter a Group Name"]){
        // 1: Make sure group name is not blank
        UITextField *groupNameUITF = [alertView textFieldAtIndex:0];
        if([groupNameUITF.text  isEqual: @""]){
            UIAlertView *blankError = [[UIAlertView alloc] initWithTitle:@"Error: Blank Fields" message:@"Please do not leave any fields blank. Enter a group name." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [blankError show];
        }
        else{
            // 2: Create new group with given strings
            
            // 3: Segue on success
            [self performSegueWithIdentifier:@"VC2toVC" sender:self];

        }
    }
    else if([alertView.title isEqual:@"Error: Blank Fields"]){
        if([alertView.message isEqual:@"Please do not leave any fields blank. Enter a group name and password."]){
            UIAlertView *groupNameAlert = [[UIAlertView alloc] initWithTitle:@"Enter a Group Name and Password" message:@"Please enter a name for your group and a access password." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
            groupNameAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            UITextField *groupNameAlertTextField = [groupNameAlert textFieldAtIndex:0];
            UITextField *groupPasswordTextField = [groupNameAlert textFieldAtIndex:1];
            groupNameAlertTextField.placeholder = @"Group Name";
            groupPasswordTextField.placeholder = @"Password";
            [groupNameAlert show];
        }
        else{
            UIAlertView *groupNameAlert = [[UIAlertView alloc] initWithTitle:@"Enter a Group Name" message:@"Please enter a name for your group." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
            groupNameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *groupNameAlertTextField = [groupNameAlert textFieldAtIndex:0];
            groupNameAlertTextField.placeholder = @"Group Name";
            [groupNameAlert show];
        }
    }
}
@end
