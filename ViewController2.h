//
//  ViewController2.h
//  EECS441P1
//
//  Created by Jacob Howcroft on 9/11/13.
//  Copyright (c) 2013 Jacob Howcroft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Collabrify.framework/Headers/Collabrify.h"
#import "ViewController.h"

@interface ViewController2 : UIViewController <UIAlertViewDelegate, CollabrifyClientDataSource, CollabrifyClientDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *createGroupButton;
@property (weak, nonatomic) IBOutlet UIButton *joinGroupButton;
@property (strong, nonatomic) NSData *data;
@property (strong, nonatomic) CollabrifyClient *client;
@property (strong, nonatomic) NSArray *tags;

@end
