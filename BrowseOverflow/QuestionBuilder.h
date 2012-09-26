//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by Maximilian Tagher on 9/22/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionBuilder : NSObject

//@property NSArray *arrayToReturn;


- (NSArray *)questionsFromJSON: (NSString *)objectNotation error: (NSError **)error;

@end
