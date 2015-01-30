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
    NSMutableDictionary * dictionaryOfSections;
    NSMutableArray * arrayOfSections;
    NSMutableArray * mutableTest;
}

@end

@implementation VZGroceryListController


- (void)viewDidLoad
{
    [super viewDidLoad];
    mutableTest = [@[] mutableCopy];
    arrayOfSections = [@[] mutableCopy];
    dictionaryOfSections = [@{} mutableCopy];
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dictionaryOfSections.allKeys.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * keyForDict = @"";
    
    int numberOfSections = 0;
    
    NSArray * allKeys = dictionaryOfSections.allKeys;
    
    if(allKeys.count >= section) {
        keyForDict = allKeys[section];
    }
    
    if(dictionaryOfSections[keyForDict]) {
        numberOfSections = (int)((NSArray *)dictionaryOfSections[keyForDict]).count;
    }
    
    return numberOfSections;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString * keyForDict = @"";
    
    NSArray * allKeys = dictionaryOfSections.allKeys;
    
    if(allKeys.count >= indexPath.section) {
        keyForDict = allKeys[indexPath.section];
    }
    
    if(dictionaryOfSections[keyForDict]) {
        VZObject * objectForCell = (VZObject *)((NSArray *)(dictionaryOfSections[keyForDict])[indexPath.row]);
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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSArray * allKeys = dictionaryOfSections.allKeys;
//    return allKeys[section];
//}


- (void) addObject:(VZObject *)object
{
    NSMutableArray * innerArray = [NSMutableArray new];
    
    if(dictionaryOfSections[object.objectPriority]) {
        innerArray = dictionaryOfSections[object.objectPriority];
        [innerArray addObject:object];
        dictionaryOfSections[object.objectPriority] = innerArray;
    } else {
        dictionaryOfSections[object.objectPriority] = [@[object] mutableCopy];
    }
    
    [mutableTest addObject:object];
    
    if(mutableTest.count > 1) {
        NSMutableArray * testArray = [NSMutableArray new];
        
        [[mutableTest valueForKeyPath:@"@distinctUnionOfObjects.self"] enumerateObjectsUsingBlock:^(NSNumber * number, NSUInteger idx, BOOL *stop) { // change to number
            NSIndexSet *indexSet = [mutableTest indexesOfObjectsPassingTest:^BOOL(NSNumber * n, NSUInteger idx, BOOL *stop) {
                return [n isEqual:number];
            }];
            
            [testArray addObject:[[mutableTest objectsAtIndexes:indexSet] mutableCopy]];
        }];
        
        NSArray * sortedDatesArray = [testArray sortedArrayUsingComparator:^(id a, id b) { // change to number
            
            NSNumber * res1;
            NSNumber * res2;
            
            res1 = ((VZObject *)[b objectAtIndex:0]).objectPriority;
            res2 = ((VZObject *)[a objectAtIndex:0]).objectPriority;
            
            return [res2 compare:res1];
        }];
        
        arrayOfSections = [sortedDatesArray mutableCopy];
    }
    
    NSLog(@"array of sections is %@",arrayOfSections);//update data structure with this array

    [self.tableView reloadData]; // TODO: insert row with animation
}


@end
