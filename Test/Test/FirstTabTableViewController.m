//
//  TableViewController.m
//  Test
//
//  Created by User on 10/31/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "FirstTabTableViewController.h"
#import "TableInfoReloader.h"
#import "ItemInfoDatabase.h"
#import "RestaurantTableViewController.h"
#import "LogoAndMenu.h"


@implementation FirstTabTableViewController


- (instancetype)init
{
    if ( (self = [super initWithInputArray:[[ItemInfoDatabase database] databaseGetLogoNameAndPath] andSearchBar:YES]) )
    {
        self.navigationItem.title = @"Restaurants";
    }
    return self;
}


- (void)dealloc
{
    [super dealloc];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _sectionTitles;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *keyForDictionary = [_sectionTitles objectAtIndex:[indexPath indexAtPosition:0]];
    LogoAndMenu *logoAndMenuInfo = [_reloadTableData getInfoForCellWithKey:keyForDictionary
                                                                  andIndex:[indexPath indexAtPosition:1]];
    
    NSString *cellID = logoAndMenuInfo.logoOrCategory;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if ( !cell )
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellID] autorelease];
        
        cell.textLabel.text = logoAndMenuInfo.logoOrCategory;
        cell.imageView.image = [UIImage imageNamed:logoAndMenuInfo.logoPathOrMenu];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *keyForDictionary = [_sectionTitles objectAtIndex:[indexPath indexAtPosition:0]];
    LogoAndMenu *logoAndMenuInfo = [_reloadTableData getInfoForCellWithKey:keyForDictionary
                                                                  andIndex:[indexPath indexAtPosition:1]];
    RestaurantTableViewController *detailsViewController = [[RestaurantTableViewController alloc] initWithNavigationName:logoAndMenuInfo.logoOrCategory];
    [[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}


- (void)filterContentForSearchText:(NSString*)searchText
{
    [self loadTableInfoWithArray:[[ItemInfoDatabase database] databaseGetLogoNameAndPathWithSearchText:searchText]];
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    return YES;
}


@end
