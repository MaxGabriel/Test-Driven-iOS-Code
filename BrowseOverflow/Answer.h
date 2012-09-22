//
//  Answer.h
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/19/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

@interface Answer : NSObject

@property NSString *text;
@property Person *person;
@property int score;
@property (getter = isAccepted) BOOL accepted;

- (NSComparisonResult)compare:(Answer *)otherAnswer;




@end
