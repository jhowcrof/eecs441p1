//
//  ViewController.h
//  EECS441P1
//
//  Created by Jacob Howcroft on 9/6/13.
//  Copyright (c) 2013 Jacob Howcroft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Collabrify.framework/Headers/Collabrify.h"

@interface ViewController : UIViewController <UITextViewDelegate, UIToolbarDelegate, UIScrollViewDelegate, CollabrifyClientDataSource, CollabrifyClientDelegate>

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
@property (nonatomic) NSArray *tags;



- (IBAction)segueBack:(id)sender;

- (IBAction)undo:(id)sender;

- (IBAction)redo:(id)sender;

@end
