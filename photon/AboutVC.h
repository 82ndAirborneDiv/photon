//
//  AboutVC.h
//  photon
//
//  Created by jtq6 on 12/2/13.
//  Copyright (c) 2013 Informatics Research and Development Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AboutVC : UIViewController <UITextViewDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblVersionInfo;
@property (weak, nonatomic) IBOutlet UITextField *txtfHeader;
@property (weak, nonatomic) IBOutlet UITextView *txtvAbout;

@end
