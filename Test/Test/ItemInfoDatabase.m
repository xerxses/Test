//
//  ItemInfoDatabase.m
//  Test
//
//  Created by User on 11/3/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "ItemInfoDatabase.h"
#import "LogoAndMenu.h"


NSString * const ItemInfoDatabaseQueryForLogoNameAndPath = @"SELECT ch_restaurant.name, ch_restaurant_logo.file_path FROM ch_restaurant, ch_restaurant_logo WHERE ch_restaurant.id=ch_restaurant_logo.restaurant_id";

NSString * const ItemInfoDatabaseQueryForFavorites = @"SELECT ch_restaurant.name, ch_restaurant_logo.file_path FROM ch_restaurant, ch_restaurant_logo WHERE ch_restaurant.id=ch_restaurant_logo.restaurant_id AND ch_restaurant.name LIKE \"%@\"";

NSString * const ItemInfoDatabaseQueryForRestaurantMenu = @"SELECT ch_category.name, ch_item.name FROM ch_item, ch_category, ch_restaurant WHERE ch_item.category_id=ch_category.id AND ch_item.restaurant_id=ch_restaurant.id AND ch_restaurant.name LIKE \"%@\"";

NSString * const ItemInfoDatabaseQueryForSearchInLogotypes = @"SELECT ch_restaurant.name, ch_restaurant_logo.file_path FROM ch_restaurant, ch_restaurant_logo WHERE ch_restaurant.name LIKE \"%@%@%@\" AND ch_restaurant.id=ch_restaurant_logo.restaurant_id";

NSString * const ItemInfoDatabaseQueryForSearchInMenu = @"SELECT ch_category.name, ch_item.name FROM ch_item, ch_category, ch_restaurant WHERE ch_item.category_id=ch_category.id AND ch_item.restaurant_id=ch_restaurant.id AND ch_restaurant.name LIKE \"%@\" AND ch_item.name LIKE \"%@%@%@\"";

NSString * const ItemInfoDatabaseQueryForMenuItem = @"SELECT serving, calories, total_fat, saturated_fat, trans_fats, cholesterol, sodium, carbs FROM ch_item WHERE ch_item.name LIKE \"%@\" AND ch_item.restaurant_id=(SELECT ch_restaurant.id FROM ch_restaurant WHERE ch_restaurant.name LIKE \"%@\")";

NSString * const ItemInfoDatabaseNameOfDatabase = @"default";

NSString * const ItemInfoDatabaseTypeOfDatabase = @"db";

NSString * const ItemInfoDatabasePerсentForQuery = @"%";


@implementation ItemInfoDatabase


+ (ItemInfoDatabase *)database
{
    static ItemInfoDatabase *__sharedInstance = nil;
    
    if ( !__sharedInstance )
    {
        __sharedInstance = [[ItemInfoDatabase alloc] init];
    }
    return __sharedInstance;
}


- (instancetype)init
{
    if ( (self = [super init]) )
    {
        NSString *sqLiteDB = [[NSBundle mainBundle] pathForResource:ItemInfoDatabaseNameOfDatabase ofType:ItemInfoDatabaseTypeOfDatabase];

        if (sqlite3_open(sqLiteDB.UTF8String, &_database) != SQLITE_OK)
        {
            NSLog(@"Failed to open DB");
        }
    }
    return self;
}


- (void)dealloc
{
    sqlite3_close(_database);
    
    [super dealloc];
}


- (NSString *)stringFromChar:(const char *)charValue
{
    const char *resultCharValue = ( charValue == NULL ) ? ("") : (charValue);
    return [NSString stringWithUTF8String:resultCharValue];
}


- (NSArray *)getInfoInDatabase:(NSString *)databaseQuery
{
    static sqlite3_stmt *statement = nil;
    NSMutableArray *arrayForInfo = [NSMutableArray array];
    
    if ( sqlite3_prepare_v2(_database, [databaseQuery UTF8String], -1, &statement, nil) == SQLITE_OK )
    {
        while ( sqlite3_step(statement) == SQLITE_ROW )
        {
            char *logoOrCategoryC = (char *) sqlite3_column_text(statement, 0);
            char *logoPathOrMenuC = (char *) sqlite3_column_text(statement, 1);
            
            LogoAndMenu *logoAndMenuInfo = [LogoAndMenu logoAndMenuWithLogoOrCategory:[self stringFromChar:logoOrCategoryC]
                                                                    andLogoPathOrMenu:[self stringFromChar:logoPathOrMenuC]];
            [arrayForInfo addObject:logoAndMenuInfo];
        }
        sqlite3_finalize(statement);
    }
    return arrayForInfo;
}


- (NSArray *)databaseGetLogoNameAndPath
{
    return [self getInfoInDatabase:ItemInfoDatabaseQueryForLogoNameAndPath];
}


- (NSArray *)databaseGetLogoNameAndPathWithFavorites:(NSArray *)favorites
{
    NSMutableArray *arrayWithFavorites = [[[NSMutableArray alloc] init] autorelease];
    for ( NSUInteger i = 0; i < favorites.count; i++ )
    {
        [arrayWithFavorites addObject:[[self getInfoInDatabase:[NSString stringWithFormat:ItemInfoDatabaseQueryForFavorites, [favorites objectAtIndex:i]]] objectAtIndex:0]];
    }
    return arrayWithFavorites;
}


- (NSArray *)databaseGetLogoNameAndPathWithSearchText:(NSString *)textForSearch
{
    return [self getInfoInDatabase:[NSString stringWithFormat:ItemInfoDatabaseQueryForSearchInLogotypes, ItemInfoDatabasePerсentForQuery, textForSearch, ItemInfoDatabasePerсentForQuery]];
}


- (NSArray *)databaseGetMenuForRestaurantWithName:(NSString *)restaurantNames
{
    return [self getInfoInDatabase:[NSString stringWithFormat:ItemInfoDatabaseQueryForRestaurantMenu, restaurantNames]];
}


- (NSArray *)databaseGetMenuWithSearchText:(NSString *)textForSearch andRestaurantName:(NSString *)restaurantName
{
    return [self getInfoInDatabase:[NSString stringWithFormat:ItemInfoDatabaseQueryForSearchInMenu, restaurantName, ItemInfoDatabasePerсentForQuery, textForSearch, ItemInfoDatabasePerсentForQuery]];
}


- (NSArray *)databaseGetInfoWithSelectedItem:(NSString *)menuItem andRestaurantName:(NSString *)restaurantName
{
    static sqlite3_stmt *statement = nil;
    NSMutableArray *arrayWithItemInfo = [NSMutableArray array];
    NSString *query = [NSString stringWithFormat:ItemInfoDatabaseQueryForMenuItem, menuItem, restaurantName];

    if ( sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK )
    {
        while ( sqlite3_step(statement) == SQLITE_ROW )
        {
            for ( NSUInteger j = 0; j < 8; j++ )
            {
                char *charValue = (char *) sqlite3_column_text(statement, j);
                [arrayWithItemInfo addObject:[self stringFromChar:charValue]];
            }
        }
        sqlite3_finalize(statement);
    }
    return arrayWithItemInfo;
}


@end