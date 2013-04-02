//
//  RMMasterViewController.h
//  readmore
//
//  Created by Jason on 2/04/13.
//  Copyright (c) 2013 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMDetailViewController;

@interface RMMasterViewController : UITableViewController

@property (strong, nonatomic) RMDetailViewController *detailViewController;

@end
