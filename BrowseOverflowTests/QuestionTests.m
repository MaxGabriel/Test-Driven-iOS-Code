//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/19/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "QuestionTests.h"
#import "Question.h"
#import "Answer.h"

@interface QuestionTests()

@property Question *question;
@property Answer *lowScore;
@property Answer *highScore;

@end

@implementation QuestionTests


- (void)setUp
{
    self.question = [[Question alloc] init];
    self.question.date = [NSDate distantPast];
    self.question.title = @"Do iPhones also dream of electric sheep?";
    self.question.score = 42;
    
    Answer *accepted = [[Answer alloc] init];
    accepted.score = 42;
    accepted.accepted = YES;
    [self.question addAnswer:accepted];
    
    self.lowScore = [[Answer alloc] init];
    self.lowScore.score = -4;
    [self.question addAnswer:self.lowScore];
    
    self.highScore = [[Answer alloc] init];
    self.highScore.score = 4;
    [self.question addAnswer:self.highScore];
    
}

- (void)testQuestionCanHaveAnswersAdded
{
    Answer *myAnswer = [[Answer alloc] init];
    STAssertNoThrow([self.question addAnswer:myAnswer], @"Must be able to add answers");
}

- (void)testAcceptedAnswerIsFirst
{
    STAssertTrue([[self.question.answers objectAtIndex:0] isAccepted], @"Accepted answer comes first");
}

- (void)testHighScoreAnswerBeforeLow
{
    NSArray *answers = self.question.answers;
    NSInteger highIndex = [answers indexOfObject:self.highScore];
    NSInteger lowIndex = [answers indexOfObject:self.lowScore];
    
    STAssertTrue(highIndex < lowIndex, @"High scoring answer comes first");
    
    
}

- (void)testQuestionHasADate
{
    NSDate *testDate = [NSDate distantPast];
    self.question.date = testDate;
    STAssertEqualObjects(self.question.date, testDate, @"Question needs to provide its date");
}

- (void)testQuestionsKeepScore
{
    STAssertEquals(42, self.question.score, @"Questions need a numeric score");
}

 - (void)testQuestionHasATitel
{
    STAssertEqualObjects(self.question.title, @"Do iPhones also dream of electric sheep?", @"Question should know its title");
}


@end



