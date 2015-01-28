//
//  VZGrocerySectionsViewController.m
//  GroceryApp
//
//  Created by Vlad Zagorodnyuk on 1/28/15.
//  Copyright (c) 2015 VZ. All rights reserved.
//

#import "UIViewController+MaryPopin.h"
#import "VZGrocerySectionsViewController.h"

@interface VZGrocerySectionsViewController () {
    NSMutableArray * arrayOfSections;
}
@property (weak, nonatomic) IBOutlet UITextField *productNameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;
@end

@implementation VZGrocerySectionsViewController
@synthesize delegate;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.prioritySegment.selectedSegmentIndex = 1;
    arrayOfSections = [@[] mutableCopy];
}


- (IBAction)addButtonTapped:(id)sender
{
    [self.navigationController dismissCurrentPopinControllerAnimated:YES];
    
    if(self.productNameTextField.text.length != 0) {
        if([self.delegate respondsToSelector:@selector(addObject:)]) {
            VZObject * objectToAdd = [[VZObject alloc] initWithName:self.productNameTextField.text andPriority:[NSNumber numberWithInteger:self.prioritySegment.selectedSegmentIndex]];
            [self.delegate addObject:objectToAdd];
        }
    }
}


@end
