//
//  IssuesManager.m
//  photon
//
//  Created by jtq6 on 11/5/13.
//  Copyright (c) 2013 Informatics Research and Development Lab. All rights reserved.
//

#import "IssuesManager.h"
#import "Issue.h"
#import "Article.h"

#import "NSString+HTML.h"
#import "MWFeedParser.h"


@implementation IssuesManager

-(id)initWithTestData
{
    if (self = [super init]) {
        
        self.issues = [[NSMutableArray alloc]init];
        self.keywords = [[NSMutableDictionary alloc]init];
        [self loadTestData];
        
    };

    return self;
    
}

-(id)initWithFeedParser
{
    
    if (self = [super init]) {
        
        self.parsedIssues = [[NSMutableDictionary alloc]init];
        self.keywords = [[NSMutableDictionary alloc]init];
        self.parsedItems  = [[NSMutableArray alloc] init];
        self.parsedJsonBlobs  = [[NSMutableArray alloc] init];
        
        NSURL *feedURL = [NSURL URLWithString:@"http://t.cdc.gov/feed.aspx?feedid=100"];
        
        _feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
        _feedParser.delegate = self;
        _feedParser.feedParseType = ParseTypeFull; // parse feed info and all items
        _feedParser.connectionType = ConnectionTypeAsynchronously;
        [_feedParser parse];

        
    };
    
    return self;
    
}

-(Issue *)newIssueWithTitle:(NSString *)title
{
    Issue *issue = [_parsedIssues objectForKey:title];

    if (issue == nil) {
        issue = [[Issue alloc]initWithTitle:title];
        [_parsedIssues setObject:issue forKey:title];
    }
    
    return issue;
    
}

-(Article *)newArticleWithTitle:(NSString *)title inIssue:(Issue *)currIssue
{
    Article *newArticle = [[Article alloc] initWithTitle:title];
    [currIssue.articles addObject:newArticle];
    newArticle.issue = currIssue;
    return newArticle;
                           
}

-(NSArray *)articlesWithKeyword:(NSString *)keyword
{
    NSArray *articles = [_keywords objectForKey:keyword];
    return articles;
}

                           
-(void)loadTestData
{
    
    NSError *err = nil;
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Issues" ofType:@"json"];
    NSArray *testIssues = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath]
                                                          options:kNilOptions
                                                            error:&err];
    Issue *currIssue = nil;
    Article *currArticle = nil;
    NSMutableArray *articlesWithKeyword = nil;
    
    NSLog(@"Imported Test Issues: %@", testIssues);
    
    for (NSDictionary *issue in testIssues)
    {
        // create and add issue
        currIssue = [self newIssueWithTitle:[issue valueForKey:@"title"]];
        NSLog(@"Issue title: %@", [issue valueForKey:@"title"]);

        // get collection of articles for currrent issue
        NSArray *newArticles = [issue valueForKey:@"articles"];
        
        NSLog(@"articles: %@", newArticles);
        for (NSDictionary *article in newArticles) {
            
            // add new article to current issues
            NSLog(@"title: %@", [article valueForKey:@"title"]);
            currArticle = [self newArticleWithTitle:[article valueForKey:@"title"]  inIssue:currIssue];
            
            NSLog(@"url: %@", [article valueForKey:@"url"]);
            currArticle.url = [article valueForKey:@"url"];
            
            currArticle.already_know = [article valueForKey:@"already_known"];
            NSLog(@"already_known: %@", [article valueForKey:@"already_known"]);
            
            currArticle.added_by_report = [article valueForKey:@"added_by_report"];
            NSLog(@"added_by_report: %@", [article valueForKey:@"added_by_report"]);
            
            currArticle.implications = [article valueForKey:@"implications"];
            NSLog(@"implications: %@", [article valueForKey:@"implications"]);
            
            // get collection of articles for currrent issue
            NSArray *newKeywords = [article valueForKey:@"keywords"];
            
            NSLog(@"tags: %@", newKeywords);
            for (NSDictionary *keyword in newKeywords) {
                NSString *currKeyword = [keyword valueForKey:@"keyword"];
                if ((articlesWithKeyword = [_keywords objectForKey:currKeyword]) == nil) {
                    articlesWithKeyword = [[NSMutableArray alloc] initWithObjects:currArticle, nil];
                    [_keywords setObject:articlesWithKeyword forKey:currKeyword];
                    
                } else {
                    [articlesWithKeyword addObject:currArticle];
                }
                [currArticle.tags addObject:currKeyword];
            };
        }
    }
    
    
}

#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
	NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
	NSLog(@"Parsed Feed Info: “%@”", info.title);
	//self.title = info.title;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
	NSLog(@"Parsed Feed Item: “%@”", item.title);
	if (item)
    {
        [_parsedItems addObject:item];
        [_parsedJsonBlobs addObject:item.summary];
    }
    
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
	NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    [self parseFeedData];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"FeedDataUpdated"
     object:self];

}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
	NSLog(@"Finished Parsing With Error: %@", error);
    if (_parsedItems.count == 0) {
        //self.title = @"Failed"; // Show failed message in title
    } else {
        // Failed but some items parsed, so show and inform of error
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                        message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //[self updateTableWithParsedItems];
}

-(void)parseFeedData
{
    NSError *err = nil;

    Issue *currIssue = nil;
    Article *currArticle = nil;
    NSMutableArray *articlesWithKeyword = nil;
    
    
    for (NSString *blob in _parsedJsonBlobs)
    {
        id jsonData = [blob dataUsingEncoding:NSUTF8StringEncoding]; //if input is NSString
        NSDictionary *issue = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&err];
        
        // create and add issue
        currIssue = [self newIssueWithTitle:[issue valueForKey:@"title"]];
        NSLog(@"Issue title: %@", [issue valueForKey:@"title"]);
        
        // get collection of articles for currrent issue
        NSArray *newArticles = [issue valueForKey:@"articles"];
        
        NSLog(@"articles: %@", newArticles);
        for (NSDictionary *article in newArticles) {
            
            // add new article to current issues
            NSLog(@"title: %@", [article valueForKey:@"title"]);
            currArticle = [self newArticleWithTitle:[article valueForKey:@"title"]  inIssue:currIssue];
            
            NSLog(@"url: %@", [article valueForKey:@"url"]);
            currArticle.url = [article valueForKey:@"url"];
            
            currArticle.already_know = [article valueForKey:@"already_known"];
            NSLog(@"already_known: %@", [article valueForKey:@"already_known"]);
            
            currArticle.added_by_report = [article valueForKey:@"added_by_report"];
            NSLog(@"added_by_report: %@", [article valueForKey:@"added_by_report"]);
            
            currArticle.implications = [article valueForKey:@"implications"];
            NSLog(@"implications: %@", [article valueForKey:@"implications"]);
            
            // get collection of articles for currrent issue
            NSArray *newKeywords = [article valueForKey:@"tags"];
            
            NSLog(@"tags: %@", newKeywords);
            for (NSDictionary *keyword in newKeywords) {
                NSString *currKeyword = [keyword valueForKey:@"tag"];
                if ((articlesWithKeyword = [_keywords objectForKey:currKeyword]) == nil) {
                    articlesWithKeyword = [[NSMutableArray alloc] initWithObjects:currArticle, nil];
                    [_keywords setObject:articlesWithKeyword forKey:currKeyword];
                    
                } else {
                    [articlesWithKeyword addObject:currArticle];
                }
                [currArticle.tags addObject:currKeyword];
            };
        }
    }
    
    _issues = [_parsedIssues allValues];
    
}


@end
