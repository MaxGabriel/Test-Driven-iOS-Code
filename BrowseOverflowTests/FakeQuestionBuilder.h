//
//  FakeQuestionBuilder.h
//  BrowseOverflow
//
//  Created by Maximilian Tagher on 9/22/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "QuestionBuilder.h"

@class Question;

@interface FakeQuestionBuilder : QuestionBuilder

@property (copy) NSString *JSON;
@property (copy) NSArray *arrayToReturn;
@property (copy) NSError *errorToSet;

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error;

@end
