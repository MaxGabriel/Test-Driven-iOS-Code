//
//  Question.h
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/19/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;

@interface Question : NSObject

@property NSDate *date;
@property (copy) NSString *title;
@property int score;
@property (readonly) NSArray *answers;

- (void)addAnswer:(Answer *)answer;

@end
