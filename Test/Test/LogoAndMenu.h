//
//  LogoAndMenu.h
//  Test
//
//  Created by User on 11/10/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LogoAndMenu : NSObject


@property (nonatomic, copy) NSString *logoOrCategory;
@property (nonatomic, copy) NSString *logoPathOrMenu;


+ (instancetype)logoAndMenuWithLogoOrCategory:(NSString *)logoOrCategory
                            andLogoPathOrMenu:(NSString *)logoPathOrMenu;


@end
