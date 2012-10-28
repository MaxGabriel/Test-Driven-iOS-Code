//
//  MockStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Maximilian Tagher on 9/21/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator : StackOverflowCommunicator

@property (readonly)BOOL wasAskedToFetchQuestions;

#warning unimplemented. 
@property (readonly)BOOL wasAskedToFetchBody;

@end
