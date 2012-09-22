//
//  Answer.m
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/19/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "Answer.h"
#import "Person.h"

@implementation Answer

- (NSComparisonResult)compare:(Answer *)otherAnswer {
    if (self.accepted && !(otherAnswer.accepted)) {
        return NSOrderedAscending;
    } else if (!self.accepted && otherAnswer.accepted) {
        return NSOrderedDescending;
    }
    
    if (self.score > otherAnswer.score) {
        return NSOrderedAscending;
    } else if (self.score <otherAnswer.score) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

@end
