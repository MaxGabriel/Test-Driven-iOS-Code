//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/20/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "Topic.h"
#import "QuestionBuilder.h"

@implementation StackOverflowManager

NSString *StackOverflowManagerError = @"StackOverflowManagerError";

- (void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate {
    if (newDelegate &&
        ![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol" userInfo:nil] raise];
    }
    _delegate = newDelegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic {
    [self.communicator searchForQuestionsWithTag: topic.tag];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error {
    
    [self tellDelegateAboutQuestionSearchError:error];
}

- (void)receivedQuestionsFromJSON:(NSString *)objectNotation
{
    
    
    NSError *error = nil;
    
    NSArray *questions = [self.questionBuilder questionsFromJSON:objectNotation error:&error];
    NSLog(@"Questions from Question builder are %@",questions);
    NSLog(@"Error is %@",error);
    
    if (!questions) {
        [self tellDelegateAboutQuestionSearchError: error];
        
        
//        NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerErrorQuestionSearchCode userInfo:@{NSUnderlyingErrorKey : error}];
//        [self.delegate fetchingQuestionsFailedWithError:reportableError];
        
    } else {
        
        [self.delegate didReceiveQuestions:questions];
        
    }

}


- (void)tellDelegateAboutQuestionSearchError: (NSError *)error {
    NSError *reportableError;
    if (error) {
        reportableError = [NSError errorWithDomain:StackOverflowManagerError
                                                       code:StackOverflowManagerErrorQuestionSearchCode
                                                   userInfo:@{NSUnderlyingErrorKey:error}];
    } else {
        reportableError = [NSError errorWithDomain:StackOverflowManagerError
                                                       code:StackOverflowManagerErrorQuestionSearchCode
                                                   userInfo:nil];
    }
    
    
    [self.delegate fetchingQuestionsFailedWithError:reportableError];
}




@end
