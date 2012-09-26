//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Maximilian Tagher on 9/22/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "FakeQuestionBuilder.h"
#import "Question.h"

@implementation FakeQuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error
{
    self.JSON = objectNotation;
    if (error) {
        *error = self.errorToSet;
    }
    if (!self.arrayToReturn) {
        return nil;
    }
    return self.arrayToReturn;
}

@end
