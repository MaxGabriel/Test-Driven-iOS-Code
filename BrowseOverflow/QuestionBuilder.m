//
//  QuestionBuilder.m
//  BrowseOverflow
//
//  Created by Maximilian Tagher on 9/22/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

@implementation QuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error
{
    NSParameterAssert(objectNotation != nil);
    
    
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    NSDictionary *parsedObject = (id)jsonObject;
    
    if (parsedObject == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:@"QuestionBuilderErrorDomain" code:QuestionBuilderInvalidJSONError userInfo:nil];
        }
        return nil;
    }
    
    
    NSArray *questions = [parsedObject objectForKey:@"questions"];
    if (questions == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:@"QuestionBuilderErrorDomain" code:QuestionBuilderMissingDataError userInfo:nil];
        }
        return nil;
    }
    
    NSArray *dictionaryArray = [parsedObject objectForKey:@"questions"];
    NSArray *questionArray = @[];
    for (NSDictionary *dict in dictionaryArray) {
        Question *question = [[Question alloc] init];
        
        NSNumber *timeInterval = [dict objectForKey:@"creation_date"];
        question.date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
        
        NSString *title = [dict objectForKey:@"title"];
        question.title = title;
        
        NSNumber *score = [dict objectForKey:@"score"];
        question.score = [score intValue];
        
//
//        
        NSDictionary *askerDictionary = [dict objectForKey:@"owner"];
        
        NSString *baseString = @"http://www.gravatar.com/avatar/";
        NSString *gravatarNumber = [askerDictionary objectForKey:@"email_hash"];
        NSString *avatarURL = nil;
        if (gravatarNumber) {
            avatarURL = [baseString stringByAppendingString:gravatarNumber];
        }
        
        if (avatarURL) {
            Person *asker = [[Person alloc] initWithName:[askerDictionary objectForKey:@"display_name"] avatarLocation:avatarURL];
            //
            question.asker = asker;
        }
        
        
        questionArray = [questionArray arrayByAddingObject:question];
    }

    return questionArray;
}

@end
