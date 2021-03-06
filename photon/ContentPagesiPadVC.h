//
//  ContentPagesiPadVC.h
//  photon
//
//  Created by Greg on 2/6/14.
//  Copyright (c) 2014 Informatics Research and Development Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Issue.h"
#import "FeedArticle.h"
#import "ArticleSelectionDelegate.h"

@interface ContentPagesiPadVC : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate, ArticleSelectionDelegate>

@property(nonatomic, weak) Issue *issue;
@property(nonatomic, weak) FeedArticle *article;



- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageHeaders;
@property (strong, nonatomic) NSArray *pageText;
@property (strong, nonatomic) NSArray *navbarTitles;
@property (strong, nonatomic) NSArray *icons;

@end
