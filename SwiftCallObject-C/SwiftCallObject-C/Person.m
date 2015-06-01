//
//  Person.m
//  SwiftCallObject-C
//
//  Created by baijiawei on 15/5/14.
//  Copyright (c) 2015年 GarveyCalvin. All rights reserved.
//

#import "Person.h"
#import "SwiftCallObject-C-Bridging-Header.h"

@implementation Person

- (void)print
{
    NSLog(@"name is %@", self.name);
}

+ (id)personWithName:(NSString *)name
{
    Person *person = [[Person alloc] init];
    person.name = name;
    return person;
}

@end
