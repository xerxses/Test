//
//  MainTableViewController.h
//  Test
//
//  Created by User on 11/14/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TableInfoReloader;


@interface MainTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>
{
    NSArray *_sectionTitles;
    TableInfoReloader *_reloadTableData;
}


- (instancetype)initWithInputArray:(NSArray *)inputArray andSearchBar:(BOOL)isNeed;
- (void)loadTableInfoWithArray:(NSArray *)inputArray;


@end
