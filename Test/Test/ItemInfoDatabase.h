//
//  ItemInfoDatabase.h
//  Test
//
//  Created by User on 11/3/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@class LogoAndMenu;


@interface ItemInfoDatabase : NSObject
{
    sqlite3 *_database;
}


+ (ItemInfoDatabase *)database;
- (NSArray *)databaseGetInfoWithSelectedItem:(NSString *)menuItem andRestaurantName:(NSString *)restaurantName;
- (NSArray *)databaseGetLogoNameAndPath;
- (NSArray *)databaseGetLogoNameAndPathWithSearchText:(NSString *)textForSearch;
- (NSArray *)databaseGetMenuForRestaurantWithName:(NSString *)restaurantName;
- (NSArray *)databaseGetMenuWithSearchText:(NSString *)textForSearch andRestaurantName:(NSString *)restaurantName;
- (NSArray *)databaseGetLogoNameAndPathWithFavorites:(NSArray *)favorites;


@end
