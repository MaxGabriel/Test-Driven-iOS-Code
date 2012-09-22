//
//  Topic.m
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/19/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "Topic.h"
#import "Question.h"

@interface Topic()

@property NSArray *questions;

@end

@implementation Topic

-(id)initWithName:(NSString *)newName tag:(NSString *)tag
{
    if ((self = [super init])) {
        _name = [newName copy];
        _tag = [tag copy];
        _questions = [[NSArray alloc] init];
    }
    
    return self;

}

- (void)addQuestion:(Question *)question
{
    NSArray *newQuestions = [self.questions arrayByAddingObject:question];
    if ([newQuestions count] > 20) {
        newQuestions = [self sortQuestionsLatestFirst:newQuestions];
        newQuestions = [newQuestions subarrayWithRange:NSMakeRange(0, 20)];
    }
    self.questions = newQuestions;
}

- (NSArray *)sortQuestionsLatestFirst:(NSArray *)questionList
{
    return [self.questions sortedArrayUsingComparator:^(id obj1, id obj2) {
        Question *q1 = (Question *)obj1;
        Question *q2 = (Question *)obj2;
        return [q2.date compare:q1.date];
    }];
}

- (NSArray *)recentQuestions
{
    return [self sortQuestionsLatestFirst:self.questions];

}

@end
