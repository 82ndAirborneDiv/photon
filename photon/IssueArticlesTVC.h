//
//  IssueArticlesTVC.h
//  photon
//
//  Created by jtq6 on 11/7/13.
//  Copyright (c) 2013 Informatics Research and Development Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Issue.h"
#import "Article.h"
#import "ArticleSelectionDelegate.h"
#import "ModalViewDelegate.h"

@interface IssueArticlesTVC : UITableViewController <ModalViewDelegate>

@property(nonatomic, weak) Issue *issue;
@property(nonatomic, weak) Article *article;

- (IBAction)refresh:(id)sender;
- (void)didDismissModalView;

@end
