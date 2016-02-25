//
//  AppDelegate.h
//  Test
//
//  Created by User on 10/29/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FirstTabController;
@class SecondTabController;


@interface AppDelegate : NSObject <UIApplicationDelegate>
{
    UITabBarController *_tabBarViewControllers;
}


@property (nonatomic, retain) UIWindow *window;


@end

