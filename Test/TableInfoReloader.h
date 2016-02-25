//
//  TableInfoReloader.h
//  Test
//
//  Created by User on 11/11/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LogoAndMenu;


@interface TableInfoReloader : NSObject
{
    BOOL _isKeyChooseHowAddCategory;
    NSArray *_arrayWithStartData;
    NSMutableArray *_sectionTitles;
    NSMutableDictionary *_dictionaryForCategory;
}


@property (nonatomic, copy, readonly) NSArray *sectionTitles;
@property (nonatomic, copy, readonly) NSDictionary *dictionaryForCategory;


- (instancetype)init;
- (void)reloadDataForTableCells:(NSArray *)inputArray;
- (NSUInteger)getNumberOfRowsInSection:(NSString *)keyForDictionary;
- (LogoAndMenu *)getInfoForCellWithKey:(NSString *)forDictionary andIndex:(NSUInteger)forArray;
- (NSArray *)getSectionTitles;


@end
