//
//  VZObject.h
//  GroceryApp
//
//  Created by Vlad Zagorodnyuk on 1/28/15.
//  Copyright (c) 2015 VZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VZObject : NSObject

- (id)initWithName:(NSString *)objectName andPriority:(NSNumber *)priority;

@property (strong, nonatomic) NSString * objectName;
@property (strong, nonatomic) NSNumber * objectPriority;

@end
