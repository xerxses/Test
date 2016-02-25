//
//  RestaurantControllerTableViewController.m
//  Test
//
//  Created by User on 11/7/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "RestaurantTableViewController.h"
#import "ItemTableViewController.h"
#import "ItemInfoDatabase.h"
#import "LogoAndMenu.h"
#import "TableInfoReloader.h"


NSString * const RestaurantTableViewControllerWhiteStarForFavorites = @"\u2606";

NSString * const RestaurantTableViewControllerBlackStarForFavorites = @"\u2605";

NSString * const RestaurantTableViewControllerKeyForUserDefaults = @"favorites";

NSString * const RestaurantTableViewControllerTrackName = @"Fav";
            //   play when user add restaurant in favorites
NSString * const RestaurantTableViewControllerTrackType = @"wav";


@interface RestaurantTableViewController ()


@property (nonatomic, retain) AVAudioPlayer *playerForAddInFavorites;


@end


@implementation RestaurantTableViewController


@synthesize playerForAddInFavorites;


- (instancetype)initWithNavigationName:(NSString *)textNavName
{
    if ( (self = [super initWithInputArray:[[ItemInfoDatabase database] databaseGetMenuForRestaurantWithName:textNavName] andSearchBar:YES]) )
    {
        self.navigationItem.title = textNavName;
        
        NSError *err = nil;
        
        playerForAddInFavorites = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:RestaurantTableViewControllerTrackName ofType:RestaurantTableViewControllerTrackType]] error:&err];
        [playerForAddInFavorites prepareToPlay];
        
        if ( ![[[NSUserDefaults standardUserDefaults] objectForKey:RestaurantTableViewControllerKeyForUserDefaults] objectForKey:self.navigationItem.title] )
        {
            self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:RestaurantTableViewControllerWhiteStarForFavorites
                                                                                       style:UIBarButtonItemStylePlain
                                                                                      target:self
                                                                                      action:@selector(addFavorites:)] autorelease];
        }
        else
        {
            self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:RestaurantTableViewControllerBlackStarForFavorites
                                                                                       style:UIBarButtonItemStylePlain
                                                                                      target:self
                                                                                      action:@selector(deleteFavorites:)] autorelease];
        }
    }
    return self;
}


- (void)dealloc
{
    self.playerForAddInFavorites =  nil;
    
    [super dealloc];
}


- (void)addFavorites:(id)sender
{
    [playerForAddInFavorites play];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:RestaurantTableViewControllerBlackStarForFavorites
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:@selector(deleteFavorites:)] autorelease];
    NSMutableDictionary *dictionaryWithFavorites = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:RestaurantTableViewControllerKeyForUserDefaults]];
    [dictionaryWithFavorites setObject:self.navigationItem.title
                                forKey:self.navigationItem.title];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:dictionaryWithFavorites]
                                              forKey:RestaurantTableViewControllerKeyForUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)deleteFavorites:(id)sender
{
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:RestaurantTableViewControllerWhiteStarForFavorites
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:@selector(addFavorites:)] autorelease];
    NSMutableDictionary *dictionaryWithFavorites = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:RestaurantTableViewControllerKeyForUserDefaults]];
    [dictionaryWithFavorites removeObjectForKey:self.navigationItem.title];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:dictionaryWithFavorites]
                                              forKey:RestaurantTableViewControllerKeyForUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_sectionTitles objectAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *keyForDictionary = [_sectionTitles objectAtIndex:[indexPath indexAtPosition:0]];
    LogoAndMenu *logoAndMenuInfo = [_reloadTableData getInfoForCellWithKey:keyForDictionary
                                                                  andIndex:[indexPath indexAtPosition:1]];
    
    NSString *cellID = logoAndMenuInfo.logoPathOrMenu;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if ( !cell )
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellID] autorelease];
        cell.textLabel.text = cellID;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *keyForDictionary = [_sectionTitles objectAtIndex:[indexPath indexAtPosition:0]];
    LogoAndMenu *logoAndMenuInfo = [_reloadTableData getInfoForCellWithKey:keyForDictionary
                                                                  andIndex:[indexPath indexAtPosition:1]];
    ItemTableViewController *itemViewController = [[ItemTableViewController alloc] initWithItemName:logoAndMenuInfo.logoPathOrMenu
                                                                                andRestaurantName:self.navigationItem.title];
    [[self navigationController] pushViewController:itemViewController animated:YES];
    [itemViewController release];
    
}


- (void)filterContentForSearchText:(NSString*)searchText
{
    [self loadTableInfoWithArray:[[ItemInfoDatabase database] databaseGetMenuWithSearchText:searchText andRestaurantName:self.navigationItem.title]];
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    return YES;
}


@end
