//
//  SummaryIphoneVC.h
//  photon
//
//  Created by Greg Ledbetter on 2/20/16.
//  Copyright © 2016 Informatics Research and Development Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummaryIphoneVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *txtvArticleTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtvKnownText;
@property (weak, nonatomic) IBOutlet UITextView *txtvAddedText;
@property (weak, nonatomic) IBOutlet UITextView *txtvImplicationsText;

@end
