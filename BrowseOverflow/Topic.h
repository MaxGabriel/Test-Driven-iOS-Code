//
//  Topic.h
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/19/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Question;

@interface Topic : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *tag;

-(id)initWithName:(NSString *)newName tag:(NSString *)tag;

- (NSArray *)recentQuestions;

- (void)addQuestion:(Question *)question;

@end
