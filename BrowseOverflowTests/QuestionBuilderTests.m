//
//  QuestionBuilderTests.m
//  BrowseOverflow
//
//  Created by Maximilian Tagher on 10/2/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "QuestionBuilderTests.h"
#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

@interface QuestionBuilderTests()

@property QuestionBuilder *questionBuilder;
@property Question *question;

@end

@implementation QuestionBuilderTests

static NSString *questionJSON = @"{"
@"\"total\": 1,"
@"\"page\": 1,"
@"\"pagesize\": 30,"
@"\"questions\": ["
@"{"
@"\"tags\": ["
@"\"iphone\","
@"\"security\","
@"\"keychain\""
@"],"
@"\"answer_count\": 1,"
@"\"accepted_answer_id\": 3231900,"
@"\"favorite_count\": 1,"
@"\"question_timeline_url\": \"/questions/2817980/timeline\","
@"\"question_comments_url\": \"/questions/2817980/comments\","
@"\"question_answers_url\": \"/questions/2817980/answers\","
@"\"question_id\": 2817980,"
@"\"owner\": {"
@"\"user_id\": 23743,"
@"\"user_type\": \"registered\","
@"\"display_name\": \"Graham Lee\","
@"\"reputation\": 13459,"
@"\"email_hash\": \"563290c0c1b776a315b36e863b388a0c\""
@"},"
@"\"creation_date\": 1273660706,"
@"\"last_activity_date\": 1278965736,"
@"\"up_vote_count\": 2,"
@"\"down_vote_count\": 0,"
@"\"view_count\": 465,"
@"\"score\": 2,"
@"\"community_owned\": false,"
@"\"title\": \"Why does Keychain Services return the wrong keychain content?\","
@"\"body\": \"<p>I've been trying to use persistent keychain references.</p>\""
@"}"
@"]"
@"}";

- (void)setUp {
    self.questionBuilder = [[QuestionBuilder alloc] init];
    self.question = [[self.questionBuilder questionsFromJSON:questionJSON error:NULL] objectAtIndex:0];
    
}

- (void)testThatNilIsNotAnAcceptableAnswer
{
    STAssertThrows([self.questionBuilder questionsFromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testNilReturnedWhenStringIsNotJSON
{
    STAssertNil([self.questionBuilder questionsFromJSON:@"Not JSON" error:NULL], @"This parameter should not be parsable");
}

- (void)testErrorSetWhenStringIsNotJSON
{
    NSError *error = nil;
    [self.questionBuilder questionsFromJSON:@"Not JSON" error:&error];
    STAssertNotNil(error, @"An error occured, we should be told");
}


//- (void)testRealJSONWithoutQuestionsArrayIsError {
//    NSString *jsonString = @"{ \"noquestions\":true }";
//    STAssertNil([self.questionBuilder questionsFromJSON:jsonString error:NULL], @"No questions to parse in this JSON");
//}

- (void)testRealJSONWithoutQuestionsReturnsMissingDataError {
    NSString *jsonString = @"{ \"noquestions\": true }";
    NSError *error = nil;
    [self.questionBuilder questionsFromJSON:jsonString error:&error];
    STAssertEquals([error code], QuestionBuilderMissingDataError, @"This case should not be an invalid JSON error");
}

- (void)testJSONWithOneQuestionReturnsOneQuestionObject {
    NSError *error = nil;
    NSArray *questions = [self.questionBuilder questionsFromJSON:questionJSON error:&error];
    STAssertEquals([questions count], (NSUInteger)1, @"The builder should have created one question");
}

- (void)testQuestionCreatedFromJSONHasPropertiesPresentedInJSON {
    //STAssertEquals(self.question.questionID, 2817980, @"The question id should match the data we sent");
    STAssertEquals([self.question.date timeIntervalSince1970], (NSTimeInterval)1273660706, @"The date of the question should match the data");
    STAssertEqualObjects(self.question.title, @"Why does Keychain Services return the wrong keychain content?", @"Title should match the provided data");
    STAssertEquals(self.question.score, 2, @"Score should match the data");
    
    Person *asker = self.question.asker;
    STAssertEqualObjects([asker.avatarURL absoluteString], @"http://www.gravatar.com/avatar/563290c0c1b776a315b36e863b388a0c", @"The avatar URL should be based on the supplied email hash");
    
}


- (void)testQuestionCreatedFromEmptyObjectIsStillValidObject {
    NSString *emptyQuestion = @"{ \"questions\": [ {} ] }";
    NSArray *questions = [self.questionBuilder questionsFromJSON:emptyQuestion error:NULL];
    STAssertEquals([questions count], (NSUInteger)1, @"Question Builder must handle the partial input");
}


@end





