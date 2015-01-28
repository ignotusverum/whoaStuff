//
//  VZGroceryListController.m
//  GroceryApp
//
//  Created by Vlad Zagorodnyuk on 1/26/15.
//  Copyright (c) 2015 VZ. All rights reserved.
//


#import "VZGroceryListController.h"
#import "UIViewController+MaryPopin.h"
#import "VZGrocerySectionsViewController.h"

@interface VZGroceryListController () <VZGrocerySectionDelegate> {
    NSMutableDictionary * arrayOfSections;
}

@end

@implementation VZGroceryListController


- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayOfSections = [@{} mutableCopy];
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrayOfSections.allKeys.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * keyForDict = @"";
    
    int numberOfSections = 0;
    
    NSArray * allKeys = arrayOfSections.allKeys;
    
    if(allKeys.count >= section) {
        keyForDict = allKeys[section];
    }
    
    if(arrayOfSections[keyForDict]) {
        numberOfSections = (int)((NSArray *)arrayOfSections[keyForDict]).count;
    }
    
    return numberOfSections;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString * keyForDict = @"";
    
    NSArray * allKeys = arrayOfSections.allKeys;
    
    if(allKeys.count >= indexPath.section) {
        keyForDict = allKeys[indexPath.section];
    }
    
    if(arrayOfSections[keyForDict]) {
        VZObject * objectForCell = (VZObject *)((NSArray *)(arrayOfSections[keyForDict])[indexPath.row]);
        cell.textLabel.text = objectForCell.objectName;
    }
    
    return (UITableViewCell *)cell;
}


- (IBAction)addObjectButtonTapped:(id)sender
{
    VZGrocerySectionsViewController * grocerySectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"grocerySection"];
    grocerySectionVC.delegate = self;

    [grocerySectionVC setPopinTransitionStyle:BKTPopinTransitionStyleZoom];
    
    //Set popin alignement according to value in segmented control
    [grocerySectionVC setPopinAlignment:BKTPopinAlignementOptionCentered];
    
    //Create a blur parameters object to configure background blur
    BKTBlurParameters *blurParameters = [BKTBlurParameters new];
    blurParameters.alpha = 1.0f;
    blurParameters.radius = 8.0f;
    blurParameters.saturationDeltaFactor = 1.8f;
    blurParameters.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [grocerySectionVC setBlurParameters:blurParameters];
    
    [grocerySectionVC setPreferedPopinContentSize:CGSizeMake(280.0f, 250.0f)];
    
    //Add option for a blurry background
    [grocerySectionVC setPopinOptions:[grocerySectionVC popinOptions]|BKTPopinBlurryDimmingView];
    
    //Set popin transition direction
    [self.navigationController presentPopinController:grocerySectionVC animated:YES completion:^{}];
}


- (NSString *) getKeyForDictWithPriority:(NSNumber *) priority
{
    NSString * keyForDict = @"low";
    
    if(priority.intValue == 1) {
        keyForDict = @"medium";
    } else if(priority.intValue == 2) {
        keyForDict = @"high";
    }
    
    return keyForDict;
}


- (void) addObject:(VZObject *)object
{
    NSString * keyForDict = [self getKeyForDictWithPriority:object.objectPriority];
    
    if(arrayOfSections[keyForDict]) {
        NSMutableArray * innerArray = arrayOfSections[keyForDict];
        [innerArray addObject:object];
        arrayOfSections[keyForDict] = innerArray;
    } else {
        arrayOfSections[keyForDict] = [@[object] mutableCopy];
    }
    
    [self.tableView reloadData];
}


@end
