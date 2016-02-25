//
//  LogoAndMenu.m
//  Test
//
//  Created by User on 11/10/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "LogoAndMenu.h"


@implementation LogoAndMenu


@synthesize logoOrCategory = _logoOrCategory;
@synthesize logoPathOrMenu = _logoPathOrMenu;


+ (instancetype)logoAndMenuWithLogoOrCategory:(NSString *)logoOrCategory
                            andLogoPathOrMenu:(NSString *)logoPathOrMenu
{
    return [[[self alloc] initWithLogoOrCategory:logoOrCategory
                               andLogoPathOrMenu:logoPathOrMenu] autorelease];
}


- (instancetype)initWithLogoOrCategory:(NSString *)logoOrCategory
           andLogoPathOrMenu:(NSString *)logoPathOrMenu
{
    if ( (self = [super init]) )
    {
        self.logoOrCategory = logoOrCategory;
        self.logoPathOrMenu = logoPathOrMenu;
    }
    return self;
}


- (void)dealloc
{
    self.logoOrCategory = nil;
    self.logoPathOrMenu = nil;
    
    [super dealloc];
}


@end
