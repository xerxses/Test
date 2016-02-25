//
//  TabModel.m
//  Test
//
//  Created by User on 10/31/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "FirstTabController.h"
#import "FirstTabTableViewController.h"
#import "SecondTabController.h"


@implementation FirstTabController


- (instancetype)init
{
    if ( (self = [super init]) )
    {
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat: @"Restaurants"]
                                                         image:[UIImage imageNamed: @"restaurants-icon.png"]
                                                           tag:0] autorelease];
    }
    return self;
}


- (void)dealloc
{
    [_navigationController release];
    
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.delegate = self;
}


- (void)loadView
{
    [super loadView];
    _tableViewController = [[FirstTabTableViewController alloc] init];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:_tableViewController];
    [_navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview: [_navigationController view]];
    [_tableViewController release];
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSUInteger indexOfTab = [tabBarController.viewControllers indexOfObject:viewController];
    if ( indexOfTab == 0 )
    {
        [_navigationController popToRootViewControllerAnimated:YES];
    }
    if ( indexOfTab == 1 )
    {
        [[tabBarController.viewControllers objectAtIndex:indexOfTab] popRootControllerAnimated:YES];
    }
}


@end