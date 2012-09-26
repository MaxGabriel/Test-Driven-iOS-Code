//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/20/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StackOverflowCommunicator;
@class Topic;
@class QuestionBuilder;



@protocol StackOverflowManagerDelegate <NSObject>

- (void)fetchingQuestionsFailedWithError:(NSError *)error;
- (void)didReceiveQuestions: (NSArray *)questions;

@end


enum {
    StackOverflowManagerErrorQuestionSearchCode
};



@interface StackOverflowManager : NSObject

// Defined in implementation.
extern NSString *StackOverflowManagerError;

@property (weak, nonatomic) id<StackOverflowManagerDelegate>delegate;

@property (strong) StackOverflowCommunicator *communicator;
@property (strong) QuestionBuilder *questionBuilder;


- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;

- (void)receivedQuestionsFromJSON:(NSString *)objectNotation;


@end




