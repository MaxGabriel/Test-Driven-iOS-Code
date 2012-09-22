//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/20/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "StackOverflowManager.h"

@implementation StackOverflowManager

- (void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate {
    if (![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol" userInfo:nil] raise];
    }
    self.delegate = newDelegate;
}

@end
