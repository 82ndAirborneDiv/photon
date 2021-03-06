//
//  ContentIpadVC.h
//  photon
//
//  Created by jtq6 on 1/14/14.
//  Copyright (c) 2014 Informatics Research and Development Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleMO+Article.h"
#import "ArticleSelectionDelegate.h"
#import "ModalViewDelegate.h"
#import "PopoverViewDelegate.h"
#import "FullArticleVC.h"

@interface ContentIpadVC : UIViewController <UISplitViewControllerDelegate,UITextViewDelegate, ArticleSelectionDelegate, ModalViewDelegate, UIPopoverControllerDelegate, PopoverViewDelegate>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) UIPopoverController *infoPopoverController;

@property NSUInteger pageIndex;
@property NSString *headerText;
@property NSString *contentText;
@property NSString *imageName;
@property (weak, nonatomic) NSString *navbarTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtvArticleTitle;

@property (weak, nonatomic) IBOutlet UITextView *txtvKnownText;

@property (weak, nonatomic) IBOutlet UITextView *txtvAddedText;
@property (weak, nonatomic) IBOutlet UIView *grayedOutContentView;
@property (weak, nonatomic) IBOutlet UIView *fullArticleContentView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrlArticleView;
@property (weak, nonatomic) IBOutlet UIScrollView *summaryScrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;


@property (weak, nonatomic) IBOutlet UITextView *txtvImplicationsText;
@property (weak, nonatomic) ArticleMO *article;
@property (weak, nonatomic) IssueMO *issue;
@property (weak, nonatomic) FullArticleVC *childFullArticleVC;
- (IBAction)infoButtonAction:(UIBarButtonItem *)sender;
-(void)didTouchReadUserAgreementButton;

- (IBAction)segCtrlFullSummary:(id)sender;

@end
