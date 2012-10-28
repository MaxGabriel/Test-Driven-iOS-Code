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

/** Returns the most recent question objects associated with a topic
 
 @return An NSArray* of question objects
 */

- (NSArray *)recentQuestions;

- (void)addQuestion:(Question *)question;

/**---------------------------------------------------------------------------------------
 * @name A name under which this method appears under "Tasks"
 *  ---------------------------------------------------------------------------------------
 */

/** This is the first super-awesome method.
 
 You can also add lists, but have to keep an empty line between these blocks.
 
 - One
 - Two
 - Three
 
 @param string A parameter that is passed in.
 @return Whatever it returns.
 */
- (NSString *)someMethodWithString:(NSString *)string;

/** This is the second super-awesome method.
 
 Note that there are additional cool things here, like [direct hyperlinks](http://www.cocoanetics.com)
 
 @param number A parameter that is passed in, almost as cool as someMethodWithString:
 @return Whatever it returns.
 @see someMethodWithString:
 @warning *Warning:* A blue background.
 @bug *Bug:* A yellow background.
 */
- (NSString *)someMethodWithInteger:(NSInteger)number;


@end
