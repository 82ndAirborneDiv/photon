//
//  JsonParser.h
//  photon
//
//  Created by jtq6 on 1/26/14.
//  Copyright (c) 2014 Informatics Research and Development Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IssuesManager.h"
#import "MWFeedParser.h"



@interface JsonParser : NSObject<MWFeedParserDelegate>


@property(nonatomic, strong) NSMutableDictionary *parsedIssues;
@property(nonatomic, strong) NSMutableDictionary *parsedKeywords;
@property(nonatomic, strong) NSMutableArray *parsedItems;
@property(nonatomic, strong) NSMutableArray *parsedJsonBlobs;
@property(nonatomic, strong) NSArray *schemaParsers;
@property(nonatomic, strong) MWFeedParser *feedParser;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;




-(id)init;
-(void)updateFromFeed;
-(void)parseAndPersistTestData;
-(void)loadAndPersistPreloadData;
-(void)parseAndPersistJsonBlobs:(NSArray *)jsonBlobs;

@end
