//
//  MockStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Maximilian Tagher on 9/21/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator()


@end

@implementation MockStackOverflowCommunicator



- (void)searchForQuestionsWithTag:(NSString *)tag
{
    _wasAskedToFetchQuestions = YES;
}

@end
