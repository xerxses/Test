//
//  SecondTabController.m
//  Test
//
//  Created by User on 10/31/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "SecondTabController.h"
#import "SecondTabTableViewController.h"


@implementation SecondTabController


- (instancetype)init
{
    if ( (self = [super init]) )
    {
        self.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1]autorelease];
    }
    return self;
}


- (void)dealloc
{
    [_navigationController release];
    
    [super dealloc];
}


- (void)popRootControllerAnimated:(BOOL)canBeAnimated
{
    [_navigationController popToRootViewControllerAnimated:canBeAnimated];
}


- (void)loadView
{
    [super loadView];
    _tableViewController = [[SecondTabTableViewController alloc] init];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:_tableViewController];
    
    [_navigationController.navigationBar setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview: [_navigationController view]];
    [_tableViewController release];
}


@end