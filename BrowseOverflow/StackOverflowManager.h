//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Maximilian Gabriel on 9/20/12.
//  Copyright (c) 2012 Maximilian Gabriel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StackOverflowManagerDelegate <NSObject>



@end

@interface StackOverflowManager : NSObject

@property (weak, nonatomic) id<StackOverflowManagerDelegate>delegate;

@end
