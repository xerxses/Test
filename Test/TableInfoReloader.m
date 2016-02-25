//
//  TableInfoReloader.m
//  Test
//
//  Created by User on 11/11/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "TableInfoReloader.h"
#import "LogoAndMenu.h"


@interface TableInfoReloader ()


@property (nonatomic, copy) NSArray *arrayWithStartData;


@end


@implementation TableInfoReloader


@synthesize arrayWithStartData = _arrayWithStartData;


- (instancetype)init
{
    if ( (self = [super init]) )
    {
        _dictionaryForCategory = [[NSMutableDictionary alloc] init];
        _sectionTitles = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)dealloc
{
    self.arrayWithStartData = nil;
    [_dictionaryForCategory release];
    [_sectionTitles release];
    
    [super dealloc];
}


- (NSArray *)sortArrayWithCheckOnImageName:(NSArray *)notSortedArray
{
    NSSortDescriptor *sortDescriptorForCategory = [NSSortDescriptor sortDescriptorWithKey:@"_logoOrCategory"
                                                                                ascending:YES
                                                                                 selector:@selector(caseInsensitiveCompare:)];
    NSSortDescriptor *sortDescriptorForMenu = [NSSortDescriptor sortDescriptorWithKey:@"_logoPathOrMenu"
                                                                            ascending:YES
                                                                             selector:@selector(caseInsensitiveCompare:)];

    NSArray *arrayWithDescriptors = @[sortDescriptorForCategory, sortDescriptorForMenu];
    
    NSArray *sortedArrayForReturn = [NSArray array];
    
    if ( [notSortedArray count] > 0 )
    {
        LogoAndMenu *arrayItem = [notSortedArray objectAtIndex:0];
    
        NSUInteger logoPathOrMenuLength =[arrayItem.logoPathOrMenu length];
    
        if ( [[arrayItem.logoPathOrMenu substringFromIndex:logoPathOrMenuLength - 4] isEqualToString: @".png"] )
        {
            sortedArrayForReturn = [notSortedArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptorForCategory]];
            _isKeyChooseHowAddCategory = YES;
        }
        else
        {
            sortedArrayForReturn = [notSortedArray sortedArrayUsingDescriptors:arrayWithDescriptors];
            _isKeyChooseHowAddCategory = NO;
        }
    }
    return sortedArrayForReturn;
}


- (NSString *)giveCurrentCategory:(NSString *)putLogoOrCategory
{
    if ( _isKeyChooseHowAddCategory )
    {
        return [putLogoOrCategory substringToIndex:1];
    }
    return putLogoOrCategory;
}


- (void)reloadDataForTableCells:(NSArray *)inputArray
{
    self.arrayWithStartData = [self sortArrayWithCheckOnImageName:inputArray];
    
    [_dictionaryForCategory removeAllObjects];
    [_sectionTitles removeAllObjects];
    
    NSString *lastCategoryChar = nil;
    NSString *currentCategoryChar = nil;
    NSMutableArray *addElementsForCategory = [NSMutableArray array];
    
    for ( NSUInteger i = 0; i < [self.arrayWithStartData count]; i++ )
    {
        LogoAndMenu *logoBuf = [self.arrayWithStartData objectAtIndex:i];

        currentCategoryChar = [NSString stringWithString:[self giveCurrentCategory:logoBuf.logoOrCategory]];

        lastCategoryChar = (i == 0) ? (currentCategoryChar) : (lastCategoryChar);
        
        if ( ![lastCategoryChar isEqualToString: currentCategoryChar] )
        {
            [_dictionaryForCategory setValue:[addElementsForCategory copy] forKey:lastCategoryChar];
            [_sectionTitles addObject:[lastCategoryChar copy]];
            [addElementsForCategory removeAllObjects];
        }
        [addElementsForCategory addObject:logoBuf];
        
        lastCategoryChar = [NSString stringWithString:currentCategoryChar];
    }
    if ( [self.arrayWithStartData count] > 0 )
    {
        [_dictionaryForCategory setValue:[addElementsForCategory copy] forKey:lastCategoryChar];
        [_sectionTitles addObject:[lastCategoryChar copy]];
        [addElementsForCategory removeAllObjects];
    }
}


- (NSUInteger)getNumberOfRowsInSection:(NSString *)keyForDictionary
{
    return [[_dictionaryForCategory valueForKey:keyForDictionary] count];
}


- (LogoAndMenu *)getInfoForCellWithKey:(NSString *)forDictionary andIndex:(NSUInteger)forArray
{
    return [[_dictionaryForCategory valueForKey:forDictionary] objectAtIndex:forArray];
}


- (NSArray *)getSectionTitles
{
    return [NSArray arrayWithArray:_sectionTitles];
}


@end
