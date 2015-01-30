//
//  VZMainListInterfaceController.m
//  GroceryApp
//
//  Created by Vlad Zagorodnyuk on 1/28/15.
//  Copyright (c) 2015 VZ. All rights reserved.
//

#import "VZObject.h"
#import "VZMainListInterfaceController.h"

@interface VZMainListInterfaceController()
{
    NSMutableDictionary * arrayOfSections;
}

@property (weak, nonatomic) IBOutlet WKInterfaceTable *interfaceTable;

@end


@implementation VZMainListInterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
}


- (void)willActivate
{
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    arrayOfSections = [@{} mutableCopy];
    
    
    
    [self.interfaceTable insertRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 20)] withRowType:@"object"];
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}



@end



