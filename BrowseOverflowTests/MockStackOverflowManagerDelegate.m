//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Maximilian Tagher on 9/21/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate

- (id)init
{
    self = [super init];
    if (self) {
        self.receivedQuestions = [[NSArray alloc] init];
    }
    return self;
}

- (void)fetchingQuestionsFailedWithError:(NSError *)error
{
    self.fetchError = error;
}

- (void)didReceiveQuestions:(NSArray *)questions
{
    self.receivedQuestions = questions;
}



@end
