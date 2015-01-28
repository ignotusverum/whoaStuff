//
//  VZGrocerySectionsViewController.h
//  GroceryApp
//
//  Created by Vlad Zagorodnyuk on 1/28/15.
//  Copyright (c) 2015 VZ. All rights reserved.
//

#import "VZObject.h"
#import <UIKit/UIKit.h>

@protocol VZGrocerySectionDelegate <NSObject>

@optional
- (void) addObject:(VZObject *)object;
@end

@interface VZGrocerySectionsViewController : UIViewController

@property (nonatomic, strong) id<VZGrocerySectionDelegate> delegate;

@end
