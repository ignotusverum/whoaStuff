//
//  VZObject.m
//  GroceryApp
//
//  Created by Vlad Zagorodnyuk on 1/28/15.
//  Copyright (c) 2015 VZ. All rights reserved.
//

#import "VZObject.h"

@implementation VZObject
@synthesize objectName = _objectName,
            objectPriority = _objectPriority;


- (id)initWithName:(NSString *)objectName andPriority:(NSNumber *)priority
{
    if ((self = [super init])) {
        self.objectName = objectName;
        self.objectPriority = priority;
    }
    return self;
}


@end
