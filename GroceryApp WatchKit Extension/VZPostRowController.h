//
//  VZPostRowController.h
//  GroceryApp
//
//  Created by Vlad Zagorodnyuk on 1/28/15.
//  Copyright (c) 2015 VZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface VZPostRowController : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceLabel * objectNameLabel;

- (IBAction)doneTapped;
@end
