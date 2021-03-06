//
//  SupportVC.m
//  photon
//
//  Created by Greg Ledbetter on 11/30/15.
//  Copyright © 2015 Informatics Research and Development Lab. All rights reserved.
//

#import "SupportVC.h"

@interface SupportVC ()

@end

@implementation SupportVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    UINavigationBar.appearance.barTintColor = [UIColor colorWithRed:45.0/255.0 green:88.0/255.0 blue:167.0/255.0 alpha:1];


}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            DebugLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            DebugLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            DebugLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            DebugLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            DebugLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnEmailSupportTouchUp:(id)sender {

    if ([MFMailComposeViewController canSendMail])
    {
        self.mail = [[MFMailComposeViewController alloc] init];
        [self.mail.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];

        
        self.mail.mailComposeDelegate = self;
        [self.mail setSubject:@"MMWR Express Support"];
        NSString *messageBody = [NSString stringWithFormat:@"\n\n\nApp name:  MMWR Express for iOS \nApp version:  %@  \nDevice model:  %@ \nSystem name:  %@ \nSystem version:  %@\n%@", [APP_MGR getAppVersion], [APP_MGR getDeviceModel], [APP_MGR getDeviceSystemName], [APP_MGR getDeviceSystemVersion], [APP_MGR.issuesMgr dbStatsString]];
        [self.mail setMessageBody:messageBody isHTML:NO];
        [self.mail setToRecipients:@[@"informaticslab@cdc.gov"]];

        [self presentViewController:self.mail animated:YES completion:NULL];

    }
    else
    {
        DebugLog(@"This device cannot send email");
        UIAlertView *anAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There isn't a mail account setup on the device." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        
        [anAlert addButtonWithTitle:@"Dismiss"];
        [anAlert show];


    }

}
@end
