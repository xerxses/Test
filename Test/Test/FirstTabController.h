//
//  TabModel.h
//  Test
//
//  Created by User on 10/31/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FirstTabTableViewController;


@interface FirstTabController : UIViewController <UITabBarControllerDelegate>
{
    FirstTabTableViewController *_tableViewController;
    UINavigationController *_navigationController;
}


- (instancetype)init;


@end