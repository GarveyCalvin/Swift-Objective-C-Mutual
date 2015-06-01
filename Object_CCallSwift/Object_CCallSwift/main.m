//
//  main.m
//  Object_CCallSwift
//
//  Created by baijiawei on 15/5/17.
//  Copyright (c) 2015年 GarveyCalvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Object_CCallSwift-Swift.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *person = [[Person alloc] init];
        person.name = @"Garvey";
        [person print];
    }
    return 0;
}
