//
//  EulaVC.m
//  retro
//
//  Created by jtq6 on 9/10/13.
//  Copyright (c) 2013 jtq6. All rights reserved.
//

#import "EulaVC.h"
#import "AppManager.h"

@implementation EulaVC

AppManager *appMgr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0] ;
    self.view.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:88.0/255.0 blue:167.0/255.0 alpha:1];
    // check for diffs between ios 6 & 7

    NSString *path = [[NSBundle mainBundle] pathForResource:@"photon_eula"
                                                     ofType:@"html"];
    
    NSString *html = [NSString stringWithContentsOfFile:path
                                               encoding:NSUTF8StringEncoding
                                                  error:NULL];
    
    [self.webView loadHTMLString:html baseURL:nil];
    self.webView.delegate = self;
    self.btnAgree.accessibilityHint = @"Double tap to agree to the MMWR Express License Agreement.";

    
    if (appMgr.agreedWithEula == TRUE) {
        _btnAgree.title = @"Done";
    }
    
    [APP_MGR.usageTracker trackNavigationEvent:SC_PAGE_TITLE_EULA inSection:SC_SECTION_EULA];


}



-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAcceptTouchUp:(id)sender
{
    
    appMgr.agreedWithEula = TRUE;
    [self dismissViewControllerAnimated:YES completion:nil]; 
        
}


@end
