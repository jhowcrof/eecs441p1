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
#import <string.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self client] setDelegate:self];
    [[self client] setDataSource:self];
    
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
    
    // Disable undo and redo buttons
    self.undoButton.enabled = NO;
    self.redoButton.enabled = NO;
    
    //Initialize textSize
    [self setTextSize:0];
    
    /*      EVO ALGO        */
    self.sideString = [[NSString alloc] initWithString:self.myTextView.text];
    self.BRCounter = 0;
    [[self client] resumeEvents];
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
    } else if ([title isEqual:@"Group Closed"]) {
        segueBack:nil;
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
    /* ORIG
    
    NSLog(@"Text changed");
    // 1. Create a property on this ViewController to store the former size of the text in the textview
    // 2. In Viewdidload, initialize the former size. (after setting up the text view)
    
    // 3. Detect whether this change was an insert or delete using the former and current size
    
    
    if((abs(self.textSize - [[[self myTextView] text] length])) > 1){
        NSLog(@"Broadcast Undo/Redo");
        [self sendBroadcastUndoRedo];
    }
    else if(self.textSize < [[[self myTextView] text] length]){
        // Adding text
        NSLog(@"Broadcast Insert");
        [self sendBroadcastInsert];
    } else {
        // Deleting Text
        NSLog(@"Broadcast Delete");
        [self sendBroadcastDelete];
    }
    
    // 4. Implement a broadcast method for insert and delete (insert is kinda implemented.  You will need
    //    to use the event type field to mark insert or delete.
    // 5. In the receive handler, handle insert and delete.  Also update former size.
    // 6. Everytime the text changes, update the former size (after you broadcast).
    */
    if ([[self client] currentSessionHasEnded]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if(self.textSize < [[[self myTextView] text] length]){
        // Adding text
        // 1: Reflect in original text
        // DONE
        
        // 2: Modify the counter
        self.BRCounter++;
        
        // 3: Send a broadcast
        [self sendBroadcastInsert];
        
    } else {
        // Deleting Text
        // 1: Reflect in original text
        // DONE
        
        // 2: Modify the counter
        self.BRCounter++;
        
        // 3: Send a broadcast
        [self sendBroadcastDelete];
        
    }
    
    self.textSize = [[[self myTextView] text] length];
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
    // NSLog(@"DidEndEditing");
    
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
    [self.delegate addItemViewController:self didFinishEnteringItem:[self client]];
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


// This is called when the Undo button is pressed
- (IBAction)undo:(id)sender{
    NSUndoManager *undoManager = self.myTextView.undoManager;
    if ([undoManager canUndo]) [undoManager undo];
    if (![undoManager canUndo]) self.undoButton.enabled = NO;
    self.redoButton.enabled = YES;
}

// This is called when the Redo button is pressed
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
    // This is where the cursor is at.
    // NSLog(@"moving to cursor");
    CGRect caretRect = [self.myTextView caretRectForPosition:self.myTextView.selectedTextRange.end];
    
    if(CGRectEqualToRect(caretRect, self.oldRect))
        return;
    
    self.oldRect = caretRect;
    
    // This is the visible rect of the textview.
    CGRect visibleRect = self.myTextView.bounds;
    visibleRect.size.height -= (self.myTextView.contentInset.top + self.myTextView.contentInset.bottom);
    visibleRect.origin.y = self.myTextView.contentOffset.y;
    
    // We will scroll only if the caret falls outside of the visible rect.
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

//-------------------------------------------------//
//                                                 //
//             Receiving Broadcasts                //
//                                                 //
//-------------------------------------------------//

-(void)client:(CollabrifyClient *)client receivedEventWithOrderID:(int64_t)orderID submissionRegistrationID:(int32_t)submissionRegistrationID eventType:(NSString *)eventType data:(NSData *)data {
    NSLog(@"Received event with order ID: %lld, type: %@", orderID, eventType);
    dispatch_async(dispatch_get_main_queue(), ^{
        // 1: Parse the protocol buffer
        int length = [data length];
        char data_char[length];
        textChange::textChangeMessage *rcvd_msg = new textChange::textChangeMessage();
        [data getBytes:data_char length:length];
        rcvd_msg->ParseFromArray(data_char, length);
        
        NSString *text = [NSString stringWithCString:rcvd_msg->contentmodified().c_str() encoding:[NSString defaultCStringEncoding]];
        
        // 2: If this is your own submission
        //      - Update the counter
        //      - Update Side string
        //      - If the all broadcasts received, set myTextView text to sideString
        //      - Set the cursor to the correct location
        if (submissionRegistrationID != -1) {
            self.BRCounter--;
            
            if([eventType isEqual:@"Insert"]){
                [self insertSide:text atLocation:rcvd_msg->cursorlocation()];
            } else {
                [self deleteSide:rcvd_msg->cursorlocation()];
            }
            
            if (self.BRCounter == 0) {
                [self.myTextView setText:self.sideString];
            }
        } else {
            // SET THE CURSOR LOCATION IMPLEMENTATION
            if (self.BRCounter == 0) {
                // REFLECT CHANGES IN ORIGINAL AND SIDE
                if ([eventType isEqual:@"Insert"]) {
                    [self insertMain:text atLocation:rcvd_msg->cursorlocation()];
                    [self insertSide:text atLocation:rcvd_msg->cursorlocation()];
                } else {
                    [self deleteMain:rcvd_msg->cursorlocation()];
                    [self deleteSide:rcvd_msg->cursorlocation()];
                }
            } else {
                // REFLECT CHANGES ONLY IN SIDE
                if ([eventType isEqual:@"Insert"]) {
                    [self insertSide:text atLocation:rcvd_msg->cursorlocation()];
                } else {
                    [self deleteSide:rcvd_msg->cursorlocation()];
                }
            }
        }
    });
}

//-------------------------------------------------//
//                                                 //
//               Sending Broadcasts                //
//                                                 //
//-------------------------------------------------//

-(void)sendBroadcastInsert{
    // 1: Initialize PROTO
    textChange::textChangeMessage *msg = new textChange::textChangeMessage();
    
    // 2: PROTO: contentModified - send the character that was inserted
    unichar char_to_send = [self.myTextView.text characterAtIndex:(self.myTextView.selectedRange.location - 1)];
    msg->set_contentmodified(*new std::string([[NSString stringWithCharacters:&char_to_send length:1] UTF8String]));
    
    // 3: PROTO: cursorLocation - send the cursor location after insertion
    msg->set_cursorlocation(*new std::int64_t(self.myTextView.selectedRange.location));
    
    // 4: Send PROTO
    std::string msg_string = msg->SerializeAsString();
    NSData *msg_data = [NSData dataWithBytes:msg_string.c_str() length:msg_string.length()];
    [[self client] broadcast:msg_data eventType:@"Insert"];
}

-(void) sendBroadcastDelete{
    // 1: Initialize PROTO
    textChange::textChangeMessage *msg = new textChange::textChangeMessage();
    
    // 2: PROTO: contentModified
    // NOTHING
    
    // 3: PROTO: cursorLocation - send the cursor location after insertion
    msg->set_cursorlocation(*new std::int64_t(self.myTextView.selectedRange.location));
    
    // 4: Send PROTO
    std::string msg_string = msg->SerializeAsString();
    NSData *msg_data = [NSData dataWithBytes:msg_string.c_str() length:msg_string.length()];
    [[self client] broadcast:msg_data eventType:@"Delete"];
}

-(void) sendBroadcastUndoRedo{
    // 1: Initialize PROTO
    textChange::textChangeMessage *msg = new textChange::textChangeMessage();
    
    // 2: PROTO: contentModified - send all of the text
    msg->set_contentmodified(*new std::string([self.myTextView.text UTF8String]));
    
    // 3: PROTO: cursorLocation - send the cursor location after insertion
    msg->set_cursorlocation(*new std::int64_t(self.myTextView.selectedRange.location));
    
    std::string msg_string = msg->SerializeAsString();
    NSData *msg_data = [NSData dataWithBytes:msg_string.c_str() length:msg_string.length()];
    [[self client] broadcast:msg_data eventType:@"UndoRedo"];
}

//----------------EVO ALGO-------------------------//
/*
 
 1: Local changes reflected immediately
 2: Whenever the self makes a change, update counter
 3: Use a counter for the number of self broadcasts and self receives
 4: Whenever the counter says more self broadcasts than self receives reflect the change in sideString
 5: Only update the main string when all self broadcasts are received
 6: Treat the receiving of other member broadcasts as normal when counter is 0, just immediately alter original string and the side string
 
 
 
*/
//-------------------------------------------------//
//                                                 //
//               UNIVERSAL MODS                    //
//                                                 //
//-------------------------------------------------//

-(void) insertSide:(NSString *)text atLocation:(int)location{
    NSLog(@"Location: %d", location);
    if (location - 1 == 0) {
        // Text is at start
        self.sideString = [NSString stringWithFormat:@"%@%@", text, self.sideString];
    } else if (location - 1 == self.sideString.length) {
        // Text is at end
        self.sideString = [NSString stringWithFormat:@"%@%@", self.sideString, text];
    } else {
        // Text is in middle
        self.sideString = [NSString stringWithFormat:@"%@%@%@", [self.sideString substringToIndex:location-1], text, [self.sideString substringFromIndex:location-1]];
    }
}

-(void) deleteSide:(int)location{
    NSLog(@"Location: %d", location);
    if (location == 0) {
        // Delete is at start
        self.sideString = [self.sideString substringFromIndex:1];
    } else if (location == self.sideString.length - 2) {
        // Delete is at end
        self.sideString = [self.sideString substringToIndex:location];
    } else {
        // Text is in middle
        self.sideString =
            [NSString stringWithFormat:@"%@%@", [self.sideString substringToIndex:location], [self.sideString substringFromIndex:location + 1]];
    }
}

-(void) insertMain:(NSString *)text atLocation:(int)location{
    NSRange selectedRange = [self.myTextView selectedRange];
    NSLog(@"Location: %d", location);
    if (location - 1 == 0) {
        // Text is at start
        [[self myTextView] setText:[NSString stringWithFormat:@"%@%@", text, [[self myTextView] text]]];
    } else if (location - 1 == [[[self myTextView] text] length]) {
        // Text is at end
        [[self myTextView] setText:[NSString stringWithFormat:@"%@%@", [[self myTextView] text], text]];
    } else {
        // Text is in middle
        [[self myTextView]
            setText:[NSString stringWithFormat:@"%@%@%@", [self.myTextView.text substringToIndex:location-1], text, [self.myTextView.text substringFromIndex:location-1]]];
    }
    
    self.textSize = [[[self myTextView] text] length];
    [self.myTextView setSelectedRange:selectedRange];
}

-(void) deleteMain:(int)location{
    NSRange selectedRange = [self.myTextView selectedRange];
    NSLog(@"Location: %d", location);
    if (location == 0) {
        // Delete is at start
        [[self myTextView] setText:[self.sideString substringFromIndex:1]];
    } else if (location == self.sideString.length - 2) {
        // Delete is at end
        [[self myTextView] setText:[self.sideString substringToIndex:location]];
    } else {
        // Text is in middle
        [[self myTextView]
         setText:[NSString stringWithFormat:@"%@%@", [self.sideString substringToIndex:location], [self.sideString substringFromIndex:location + 1]]];
    }
    
    self.textSize = [[[self myTextView] text] length];
    [self.myTextView setSelectedRange:selectedRange];
    
    
}

@end
