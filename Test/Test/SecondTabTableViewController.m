//
//  SecondTabTableViewController.m
//  Test
//
//  Created by User on 11/3/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "SecondTabTableViewController.h"
#import "ItemInfoDatabase.h"
#import "LogoAndMenu.h"


NSString * const SecondTabTableViewControllerKeyForUserDefaults = @"favorites";


@implementation SecondTabTableViewController


- (instancetype)init
{
    if ( (self = [super initWithInputArray:[[ItemInfoDatabase database] databaseGetLogoNameAndPathWithFavorites:[self extractFavorites]] andSearchBar:NO]) )
    {
        self.navigationItem.title = @"Favorites";
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                                target:self
                                                                                                action:@selector(startEditing:)] autorelease];
    }
    return self;
}


- (void)dealloc
{
    [super dealloc];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self loadTableInfoWithArray:[[ItemInfoDatabase database] databaseGetLogoNameAndPathWithFavorites:[self extractFavorites]]];
}


- (NSArray *)extractFavorites
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:SecondTabTableViewControllerKeyForUserDefaults] allKeys];
}


- (void)startEditing:(id)sender
{
    [self.tableView setEditing:YES animated:YES];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                            target:self
                                                                                            action:@selector(stopEditing:)] autorelease];
}


- (void)stopEditing:(id)sender
{
    [self.tableView setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                            target:self
                                                                                            action:@selector(startEditing:)]autorelease];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( editingStyle == UITableViewCellEditingStyleDelete )
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        NSMutableDictionary *dictionaryWithFavorites = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:SecondTabTableViewControllerKeyForUserDefaults]];
        [dictionaryWithFavorites removeObjectForKey:cell.textLabel.text];
        [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:dictionaryWithFavorites] forKey:SecondTabTableViewControllerKeyForUserDefaults];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self loadTableInfoWithArray:[[ItemInfoDatabase database] databaseGetLogoNameAndPathWithFavorites:[self extractFavorites]]];
    }
}


@end
