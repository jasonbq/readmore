//
//  RMDetailViewController.h
//  readmore
//
//  Created by Jason on 2/04/13.
//  Copyright (c) 2013 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
