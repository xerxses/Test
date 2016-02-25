//
//  SecondTabController.h
//  Test
//
//  Created by User on 10/31/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SecondTabTableViewController;


@interface SecondTabController : UIViewController
{
    SecondTabTableViewController *_tableViewController;
    UINavigationController *_navigationController;
}


- (instancetype)init;
- (void)popRootControllerAnimated:(BOOL)canBeAnimated;


@end