//
//  Issue.m
//  photon
//
//  Created by jtq6 on 11/6/13.
//  Copyright (c) 2013 Informatics Research and Development Lab. All rights reserved.
//

#import "Issue.h"

@implementation Issue

-(id)initWithTitle:(NSString *)title
{
    
    if(self= [super init]) {
        
        self.title= title;
        self.articles = [[NSMutableArray alloc] init];
        self.unread = YES;
        NSArray *titleSplit = [_title componentsSeparatedByString:@"/"];
        if ([titleSplit count] == 3) {
            self.date = titleSplit[0];
            self.volume = titleSplit[1];
            self.number = titleSplit[2];
        }

    }
    
    return self;
}

-(void)updateUnreadArticleStatus
{
    int unreadCount = 0;
    
    for (Article *article in _articles)
        if (article.unread)
            unreadCount++;
    
    if (unreadCount > 0)
        self.unread = YES;
    else
        self.unread = NO;
    
}

-(Article *)getArticleWithTitle:(NSString *)title
{

    if (_articles.count == 0)
        return nil;
    
    for (Article *article in _articles) {
        if ([article.title isEqualToString:title])
            return article;
    }
    
    return nil;
    
}

-(Article *)addArticleWithTitle:(NSString *)title
{
    Article *newArticle = [[Article alloc] initWithTitle:title];
    
    [_articles addObject:newArticle];
    
    return newArticle;
    
}

-(void)replaceArticle:(Article *)oldArticle withArticle:(Article *)newArticle
{
    NSUInteger oldIndex = [_articles indexOfObject:oldArticle];
    
    [_articles replaceObjectAtIndex:oldIndex withObject:newArticle];
    
}

@end
