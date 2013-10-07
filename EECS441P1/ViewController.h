//
//  ViewController.h
//  EECS441P1
//
//  Created by Jacob Howcroft on 9/6/13.
//  Copyright (c) 2013 Jacob Howcroft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Collabrify.framework/Headers/Collabrify.h"
#import "EVO.pb.h"

@class ViewController;

@protocol ViewControllerDelegate <NSObject>
- (void)addItemViewController:(ViewController *)controller didFinishEnteringItem:(CollabrifyClient *)item;

@end



@interface ViewController : UIViewController <UITextViewDelegate, UIToolbarDelegate, UIScrollViewDelegate, UIAlertViewDelegate, CollabrifyClientDataSource, CollabrifyClientDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextView *myTextView;
@property (strong, nonatomic) IBOutlet UIView *theView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *returnButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *undoButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *redoButton;
@property (weak, nonatomic) NSMutableString *oldText;
@property (weak, nonatomic) IBOutlet UIToolbar *topToolbar;
@property CGRect oldRect;
@property (weak, nonatomic)  NSTimer *caretVisibilityTimer;
@property (nonatomic) CollabrifyClient *client;
@property (nonatomic) CollabrifySession *session;
@property (nonatomic) NSArray *tags;
@property (nonatomic) NSInteger textSize;
@property (nonatomic) NSString* sideString;
@property (nonatomic) NSInteger sideCursorLoc;
@property (nonatomic) NSInteger BRCounter;
@property (nonatomic) NSRange selectedRange;

@property (nonatomic, weak) id <ViewControllerDelegate> delegate;

- (IBAction)segueBack:(id)sender;

- (IBAction)undo:(id)sender;

- (IBAction)redo:(id)sender;

@end
