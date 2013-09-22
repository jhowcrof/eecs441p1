//
//  ViewController2.h
//  EECS441P1
//
//  Created by Jacob Howcroft on 9/11/13.
//  Copyright (c) 2013 Jacob Howcroft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Collabrify.framework/Headers/Collabrify.h"

@interface ViewController2 : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *createGroupButton;
@property (weak, nonatomic) IBOutlet UIButton *joinGroupButton;

@end
