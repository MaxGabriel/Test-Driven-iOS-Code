//
//  Person.h
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/19/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (readonly) NSString *name;
@property (readonly) NSURL *avatarURL;

- (id)initWithName:(NSString *)aName avatarLocation:(NSString *)location;

@end
