//
//  QuestionCreationTests.m
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/20/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "QuestionCreationTests.h"
#import "StackOverflowManager.h"

@interface QuestionCreationTests()

@property StackOverflowManager *mgr;

@end

@implementation QuestionCreationTests

- (void)setUp {
    self.mgr = [[StackOverflowManager alloc] init];
}

- (void)testNonConformingObjectCannotBeDelegate {
    STAssertThrows(self.mgr.delegate = (id <StackOverflowManagerDelegate>)[NSNull null], @"Non-conforming objects cannot be delegates");
}

- (void)testConformingObjectCanBeDelegate {
    id <StackOverflowManagerDelegate> delegate = [[MockStackOverFlowManagerDelegate alloc] init];
    
    STAssertNoThrow(self.mgr.delegate = delegate, @"Object conforming to the delegate protocol can be used");
}

@end
