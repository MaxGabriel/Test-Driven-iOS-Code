//
//  Person.m
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/19/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)initWithName:(NSString *)aName avatarLocation:(NSString *)location
{
    if (self = [super init]) { // two parens?
        _name = [aName copy];
        _avatarURL = [[NSURL alloc] initWithString:location];
    }
    return self;
}

@end
