//
//  Person.h
//  SwiftCallObject-C
//
//  Created by baijiawei on 15/5/14.
//  Copyright (c) 2015年 GarveyCalvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSString *name;

- (void)print;

+ (id)personWithName:(NSString *)name;

@end
