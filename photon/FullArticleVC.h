//
//  FullArticleVC.h
//  photon
//
//  Created by jtq6 on 11/26/13.
//  Copyright (c) 2013 Informatics Research and Development Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalViewDelegate.h"

@interface FullArticleVC : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) NSString *url;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) id <ModalViewDelegate> modalDelegate;

- (IBAction)btnDoneTouchUp:(id)sender;

@end
