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
    self.topToolbar.delegate = self;
    //self.scrollView.delegate = self;
    self.myTextView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Set up the above-keyboard toolbar and the Done button.
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [keyboardToolbar setBarStyle:UIBarStyleBlack];
    [keyboardToolbar setTranslucent:YES];
    UIBarButtonItem *keyboardDoneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(hideKeyboard:)];
    self.myTextView.inputAccessoryView = keyboardToolbar;
    keyboardToolbar.items = [NSArray arrayWithObject:keyboardDoneButton];
    
    // Configure the scrollView
    //[self.scrollView setScrollEnabled:YES];
    //[self.scrollView setContentSize:CGSizeMake(320, 500)];
    
    // Disable undo and redo buttons
    self.undoButton.enabled = NO;
    self.redoButton.enabled = NO;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = alertView.title;
    if ([title isEqual:@"Leaving Group"]) {
         NSLog(@"wheres waldo");
        if (buttonIndex == 0) {
            // Delete
            [[self client] leaveAndDeleteSession:YES completionHandler:^(BOOL success, CollabrifyError *error) {
                 NSLog(@"delete!!!!");
                if (success) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                } else {
                    NSLog(@"Error: %@", [error class]);
                }
            }];
        } else {
            [[self client] leaveAndDeleteSession:NO completionHandler:^(BOOL success, CollabrifyError *error) {
                 NSLog(@"no delete");
                if (success) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                } else {
                    NSLog(@"Error: %@", [error class]);
                }
            }];
        }
    }
}

// Called when the keyboard opens
- (void)keyboardOpened:(NSNotification *) notification{
    NSLog(@"keyboard opened");
    // This code came from the iOS Developer Guide
    
    // This is what worked on iOS 6
    /* NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;*/
    
    UIEdgeInsets insets = self.myTextView.contentInset;
    insets.bottom += [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    insets.bottom += self.myTextView.inputAccessoryView.frame.size.height;
    self.myTextView.contentInset = insets;
    
    insets = self.myTextView.scrollIndicatorInsets;
    insets.bottom += [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    insets.bottom += self.myTextView.inputAccessoryView.frame.size.height;
    self.myTextView.scrollIndicatorInsets = insets;
    self.oldRect = [self.myTextView caretRectForPosition:self.myTextView.selectedTextRange.end];
    
    if (![self.caretVisibilityTimer isValid]) {
        self.caretVisibilityTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(scrollCaretToVisible) userInfo:nil repeats:YES];
    }
    
    self.oldText = (NSMutableString *)self.myTextView.text;
}

// Called when the keyboard closes
- (void)keyboardClosed:(NSNotification *) notification{
    NSLog(@"keyboard closed");
    // This code came from the iOS Developer Guide
    UIEdgeInsets insets = self.myTextView.contentInset;
    insets.bottom -= [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    insets.bottom -= self.myTextView.inputAccessoryView.frame.size.height;
    self.myTextView.contentInset = insets;
    
    insets = self.myTextView.scrollIndicatorInsets;
    insets.bottom -= [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    insets.bottom -= self.myTextView.inputAccessoryView.frame.size.height;
    self.myTextView.scrollIndicatorInsets = insets;
}

- (void)textViewDidChange:(UITextView *)textView{
   // NSLog(@"Text changed");
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
   // NSLog(@"Begin editing");
    self.oldRect = [self.myTextView caretRectForPosition:self.myTextView.selectedTextRange.end];
    
    if (![self.caretVisibilityTimer isValid]) {
        self.caretVisibilityTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(scrollCaretToVisible) userInfo:nil repeats:YES];
    }
    self.oldText = (NSMutableString *)self.myTextView.text;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    //NSLog(@"DidEndEditing");
    
    [self.caretVisibilityTimer invalidate];
    self.caretVisibilityTimer = nil;
    
    if (self.oldText != (NSMutableString *)self.myTextView.text){
        if ([self.myTextView.undoManager canUndo]){
            self.undoButton.enabled = YES;
        }
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //NSLog(@"ShouldBeginEditing");
    return TRUE;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
   // NSLog(@"ShouldEndEditing");
    return TRUE;
}

- (IBAction)segueBack:(id)sender{
    NSLog(@"Return button pressed");
    if ([[self client] participantID] == [[self client] currentSessionOwner].participantID) {
        NSLog(@"I am owner");
        [self ownerLeaveSession];
    } else {
        NSLog(@"Not owner");
        [[self client] leaveAndDeleteSession:NO completionHandler:^(BOOL success, CollabrifyError *error) {
            if (success) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
    
    
}

- (IBAction)undo:(id)sender{
    NSUndoManager *undoManager = self.myTextView.undoManager;
    if ([undoManager canUndo]) [undoManager undo];
    if (![undoManager canUndo]) self.undoButton.enabled = NO;
    self.redoButton.enabled = YES;
}

- (IBAction)redo:(id)sender{
    NSUndoManager *undoManager = self.myTextView.undoManager;
    
    if ([undoManager canRedo]) [undoManager redo];
    if (![undoManager canRedo]) self.redoButton.enabled = NO;
    self.undoButton.enabled = YES;
}

// This function hides the keyboard
- (void)hideKeyboard:(id)sender{
    NSLog(@"Button pressed");
    [self.myTextView resignFirstResponder];
}

- (void)scrollCaretToVisible{
    //This is where the cursor is at.
    NSLog(@"moving to cursor");
    CGRect caretRect = [self.myTextView caretRectForPosition:self.myTextView.selectedTextRange.end];
    
    if(CGRectEqualToRect(caretRect, self.oldRect))
        return;
    
    self.oldRect = caretRect;
    
    //This is the visible rect of the textview.
    CGRect visibleRect = self.myTextView.bounds;
    visibleRect.size.height -= (self.myTextView.contentInset.top + self.myTextView.contentInset.bottom);
    visibleRect.origin.y = self.myTextView.contentOffset.y;
    
    //We will scroll only if the caret falls outside of the visible rect.
    if(!CGRectContainsRect(visibleRect, caretRect))
    {
        CGPoint newOffset = self.myTextView.contentOffset;
        
        newOffset.y = MAX((caretRect.origin.y + caretRect.size.height) - visibleRect.size.height + 5, 0);
        
        [self.myTextView setContentOffset:newOffset animated:YES];
    }
    
    
}

-(void)ownerLeaveSession{
    UIAlertView *ownerLeaveSessionAlert = [[UIAlertView alloc] initWithTitle:@"Leaving Group"
                                                                     message:@"Do you want to delete this group?"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Yes"
                                                           otherButtonTitles:@"No", nil];
    
    [ownerLeaveSessionAlert show];
}

@end
