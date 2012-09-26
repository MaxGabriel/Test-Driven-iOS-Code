//
//  QuestionCreationTests.m
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/20/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "QuestionCreationWorkflowTests.h"
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "Topic.h"
#import "MockStackOverflowCommunicator.h"
#import "FakeQuestionBuilder.h"
#import "Question.h"

@interface QuestionCreationWorkflowTests()

@property StackOverflowManager *mgr;
@property MockStackOverflowManagerDelegate *delegate;
@property NSError *underlyingError;
@property NSArray *questionArray;
@property FakeQuestionBuilder *questionBuilder;

@end

@implementation QuestionCreationWorkflowTests

- (void)setUp {
    
    Question *question = [[Question alloc] init];
    self.questionArray = @[question]; // property or what? book is unclear. 
    
    self.questionBuilder = [[FakeQuestionBuilder alloc] init];
    
    
    
    self.mgr = [[StackOverflowManager alloc] init];
    
    self.delegate = [[MockStackOverflowManagerDelegate alloc] init];
    
    self.underlyingError = [NSError errorWithDomain:@"Test domain"
                                               code:0
                                           userInfo:nil];
    
    self.mgr.questionBuilder = self.questionBuilder;
    self.mgr.delegate = self.delegate;
}

- (void)tearDown {
    self.mgr = nil;
    self.delegate = nil;
    self.underlyingError = nil;
    self.questionBuilder = nil;
    self.questionArray = nil;
    
}

#pragma mark - Delegate Tests

- (void)testNonConformingObjectCannotBeDelegate {
    STAssertThrows(self.mgr.delegate = (id <StackOverflowManagerDelegate>)[NSNull null], @"Non-conforming objects cannot be delegates");
}

- (void)testManagerAcceptsNilAsDelegate {
    STAssertNoThrow(self.mgr.delegate = nil, @"It should be acceptable to use nil as an object's delegate");
}

- (void)testConformingObjectCanBeDelegate {
    id <StackOverflowManagerDelegate> delegate = [[MockStackOverflowManagerDelegate alloc] init];
    
    STAssertNoThrow(self.mgr.delegate = delegate, @"Object conforming to the delegate protocol can be used");
}

#pragma mark - Server Tests

- (void)testAskingForQuestionsMeansRequestingData {
    MockStackOverflowCommunicator *communicator = [[MockStackOverflowCommunicator alloc] init];
    self.mgr.communicator = communicator;
    Topic *topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
    [self.mgr fetchQuestionsOnTopic: topic];
    STAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator should need to fetch data");
}

- (void)testErrorRetrunedToDelegateIsNotErrorNotifiedByCommunicator {
    MockStackOverflowManagerDelegate *delegate = [[MockStackOverflowManagerDelegate alloc] init];
    self.mgr.delegate = delegate;
    NSError *underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    [self.mgr searchingForQuestionsFailedWithError: underlyingError];
    STAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError {

    [self.mgr searchingForQuestionsFailedWithError:self.underlyingError];
    
    NSLog(@"Fetch error is %@",self.delegate.fetchError);
    NSLog(@"User info is %@",[self.delegate.fetchError userInfo]);
    NSLog(@"Underlying error is %@",[self.delegate.fetchError.userInfo objectForKey:NSUnderlyingErrorKey]);
    
    STAssertEqualObjects([[self.delegate.fetchError userInfo] objectForKey: NSUnderlyingErrorKey],self.underlyingError,@"The underlying error should be available to client code");
}


#pragma mark - Question Building

- (void)testQuestionJSONIsPassedToQuestionBuilder {
    NSString *fakeJSON = @"Fake JSON";
    
    NSLog(@"Manager is %@",self.mgr);
    NSLog(@"Manager QB is %@",self.mgr.questionBuilder);
    NSLog(@"Self QB is %@",self.questionBuilder);
    
    [self.mgr receivedQuestionsFromJSON:fakeJSON];
    
    
    STAssertEqualObjects(self.questionBuilder.JSON, fakeJSON, @"Downloaded JSON is sent to the builder");
    
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails {
    
    
    
    self.questionBuilder.arrayToReturn = nil;
    self.questionBuilder.errorToSet = self.underlyingError;
    
    NSLog(@"Delegate is %@",self.delegate);
    NSLog(@"Manager's Question Builder is %@",self.mgr.questionBuilder);
    NSLog(@"Question builder is %@",self.questionBuilder);
    NSLog(@"Delegate's questions are %@",self.delegate.receivedQuestions);
    NSLog(@"Manager's delegate is %@",self.mgr.delegate); // Equal.
    

    [self.mgr receivedQuestionsFromJSON:@"Fake JSON"];
    
    NSLog(@"Delegate's error is: %@",self.delegate.fetchError);
    NSLog(@"User info is: %@",[self.delegate.fetchError userInfo]);
    
    
    STAssertNotNil([[self.delegate.fetchError userInfo] objectForKey:NSUnderlyingErrorKey], @"The delegate should have found out about the error");
}


- (void)testDelegateNotToldAboutErrorWhenQuestionsReceived {
    self.questionBuilder.arrayToReturn = self.questionArray;
    [self.mgr receivedQuestionsFromJSON:@"Fake JSON"];
    STAssertNil([self.delegate fetchError], @"No error should be received on success");
}

- (void)testDelegateReceivesTheQuestionsDiscoveredByManager {
    self.questionBuilder.arrayToReturn = self.questionArray;
    [self.mgr receivedQuestionsFromJSON:@"Fake JSON"];
    
    
    
    
    STAssertEqualObjects(self.delegate.receivedQuestions, self.questionArray, @"The manager should have sent its questions to the delegate");
}

- (void)testEmptyArrayIsPassedToDelegate {
    self.questionBuilder.arrayToReturn = @[];
    [self.mgr receivedQuestionsFromJSON:@"Fake JSON"];
    STAssertEqualObjects(self.delegate.receivedQuestions, @[], @"Returning an empty array is not an error");
}

- (void)testDelegateCanReceiveQuestions {
    [self.delegate didReceiveQuestions:self.questionArray];
    STAssertEqualObjects(self.delegate.receivedQuestions, self.questionArray, @"Delegate's questions should match what it received");
}



@end






