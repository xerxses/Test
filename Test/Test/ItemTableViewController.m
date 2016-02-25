//
//  ItemTableViewController.m
//  Test
//
//  Created by User on 11/7/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "ItemTableViewController.h"
#import "ItemInfoDatabase.h"


@interface ItemTableViewController ()


@property (nonatomic, copy) NSArray *arrayWithItems;


@end


@implementation ItemTableViewController


@synthesize arrayWithItems;


- (instancetype)initWithItemName:(NSString *)forNavigationName andRestaurantName:(NSString *)restaurantName
{
    if ( (self = [super init]) )
    {
        self.navigationItem.title = forNavigationName;
        _itemNames = [[NSArray alloc] initWithObjects:@"Serving", @"Calories", @"Total fat", @"Saturated fat", @"Trans fats", @"Cholesterol", @"Sodium", @"Carbs", nil];
        self.arrayWithItems = [[ItemInfoDatabase database] databaseGetInfoWithSelectedItem:self.navigationItem.title andRestaurantName:restaurantName];
    }
    return self;
}


- (void)dealloc
{
    self.arrayWithItems = nil;
    [_itemNames release];
    
    [super dealloc];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_itemNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *info = [self.arrayWithItems objectAtIndex:indexPath.row];
    NSString *cellID = [_itemNames objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if ( !cell )
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:cellID] autorelease];
        cell.textLabel.text = cellID;
        cell.detailTextLabel.text = info;
    }
    return cell;
}


@end
