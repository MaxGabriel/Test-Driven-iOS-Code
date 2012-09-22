//
//  PersonTests.m
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/19/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "PersonTests.h"
#import "Person.h"

@interface PersonTests()

@property Person *person;

@end

@implementation PersonTests

- (void)setUp {
    self.person = [[Person alloc] initWithName:@"Graham Lee" avatarLocation: @"http://example.com/avatar.png"];
    
}

- (void)testThatPersonHasTheRightName
{
    STAssertEqualObjects(self.person.name, @"Graham Lee", @"expecting a person to provide its name");
}

- (void)testThatPersonHasAnAvatarURL
{
    NSURL *url = self.person.avatarURL;
    STAssertEqualObjects([url absoluteString], @"http://example.com/avatar.png", @"The person's avatar should be represented by a URL");
}

@end
