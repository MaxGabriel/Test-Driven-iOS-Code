//
//  Question.m
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/19/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "Question.h"
#import "Answer.h"

@interface Question()

@property NSMutableSet *answerSet;

@end

@implementation Question

- (id) init{
    if (self = [super init]) {
        self.answerSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addAnswer:(id)answer
{
    [self.answerSet addObject:answer];
}

-(NSArray *)answers {
    return [[self.answerSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

@end
