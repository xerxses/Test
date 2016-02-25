//
//  MainTableViewController.m
//  Test
//
//  Created by User on 11/14/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "MainTableViewController.h"
#import "TableInfoReloader.h"
#import "LogoAndMenu.h"


@interface MainTableViewController ()


@property (nonatomic, copy) NSArray *arrayWithInfoForCells;
@property (nonatomic, retain) UISearchDisplayController *searchDisplayController;


@end


@implementation MainTableViewController


@synthesize arrayWithInfoForCells = _arrayWithInfoForCells;
@synthesize searchDisplayController;


- (instancetype)initWithInputArray:(NSArray *)inputArray andSearchBar:(BOOL)isNeed
{
    if ( (self = [super init]) )
    {
        self.arrayWithInfoForCells = inputArray;
        if ( isNeed )
        {
            UISearchBar *searchBar = [[[UISearchBar alloc] init] autorelease];
            searchBar.delegate = self;
            [searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
            [searchBar sizeToFit];
            self.tableView.tableHeaderView = searchBar;
            
            searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar
                                                                        contentsController:self];
            searchDisplayController.delegate = self;
            searchDisplayController.searchResultsDataSource = self;
        }
        _reloadTableData = [[TableInfoReloader alloc] init];
        [self loadTableInfoWithArray:inputArray];
    }
    return self;
}


- (void)dealloc
{
    [_reloadTableData release];
    [_sectionTitles release];
    
    self.arrayWithInfoForCells = nil;
    self.searchDisplayController = nil;
    
    [super dealloc];
}


- (void)loadTableInfoWithArray:(NSArray *)inputArray
{
    [_reloadTableData reloadDataForTableCells:inputArray];
    _sectionTitles = [[NSArray alloc]initWithArray:[_reloadTableData getSectionTitles]];
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitles count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_reloadTableData getNumberOfRowsInSection:[_sectionTitles objectAtIndex:section]];
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger i = 0;
    NSInteger sectionTitleFind = 0;
    for ( NSString *sectionTitle in _sectionTitles )
    {
        if ( [sectionTitle isEqualToString:title] )
        {
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]
                             atScrollPosition:UITableViewScrollPositionTop
                                     animated:YES];
            sectionTitleFind = 1;
            break;
        }
        i++;
    }
    return ( sectionTitleFind == 1 ) ? (i) : (-1);
}


- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    [self loadTableInfoWithArray:self.arrayWithInfoForCells];
}


@end
