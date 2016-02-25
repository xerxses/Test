//
//  RestaurantControllerTableViewController.h
//  Test
//
//  Created by User on 11/7/14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "MainTableViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface RestaurantTableViewController : MainTableViewController <AVAudioPlayerDelegate>


- (instancetype) initWithNavigationName:(NSString *)textNavName;


@end
