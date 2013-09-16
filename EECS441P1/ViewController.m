//
//  ViewController.m
//  EECS441P1
//
//  Created by Jacob Howcroft on 9/6/13.
//  Copyright (c) 2013 Jacob Howcroft. All rights reserved.
//

// This is the first commit.  Hello World.
// Second commit Hello!

#import "ViewController.h"
#import <Collabrify/Collabrify.h>

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Receive Keyboard opened and closed notifications.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardOpened:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardClosed:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.myTextView.delegate = self;
    
    // Set up the above-keyboard toolbar and add the "Done" button.
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [keyboardToolbar setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem *keyboardDoneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(hideKeyboard:)];
    self.myTextView.inputAccessoryView = keyboardToolbar;
    keyboardToolbar.items = [NSArray arrayWithObject:keyboardDoneButton];
    
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(400, 1000)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Called when the keyboard opens
- (void)keyboardOpened:(NSNotification *) notification{
    NSLog(@"keyboard opened");
    // This code came from the iOS Developer Guide
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

// Called when the keyboard closes
- (void)keyboardClosed:(NSNotification *) notification{
    NSLog(@"keyboard closed");
    // This code came from the iOS Developer Guide
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"Begin editing");

}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"DidEndEditing");
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"ShouldBeginEditing");
    return TRUE;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"ShouldEndEditing");
    return TRUE;
}

// This function hides the keyboard
- (void)hideKeyboard:(id)sender{
    NSLog(@"Button pressed");
    [self.myTextView resignFirstResponder];
}

@end
