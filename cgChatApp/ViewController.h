//
//  ViewController.h
//  cgChatApp
//
//  Created by Wim on 24/01/13.
//  Copyright (c) 2013 Wim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *txtChatbox;
@property (strong, nonatomic) IBOutlet UITextField *txtChatInput;

- (IBAction)chatInputEnd:(id)sender;
- (IBAction)btnHunter:(UIBarButtonItem *)sender;
- (IBAction)btnPrey:(UIBarButtonItem *)sender;
- (IBAction)btnLeader:(UIBarButtonItem *)sender;

@end
