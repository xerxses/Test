//
//  ItemTableViewController.h
//  Test
//
//  Created by User on 11/7/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ItemTableViewController : UITableViewController
{
    NSArray *_itemNames;
}


- (instancetype) initWithItemName:(NSString *)textNavName andRestaurantName:(NSString *)navigationItemTitle;;


@end
