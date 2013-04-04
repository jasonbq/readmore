//
//  RMDetailViewController.m
//  readmore
//
//  Created by Jason on 2/04/13.
//  Copyright (c) 2013 Jason. All rights reserved.
//

#import "RMDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RMDetailViewController () <UITextViewDelegate>
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation RMDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
    
    // config textView
    self.textView.layer.cornerRadius = 10;
    self.textView.clipsToBounds = YES;
    [self.textView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.textView.layer setBorderWidth:2.0];
    
    // add tap gesture on textView
    UITapGestureRecognizer *oneTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    oneTapGestureRecognizer.numberOfTapsRequired = 1;
    [self.textView addGestureRecognizer:oneTapGestureRecognizer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    self.textView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - UITextView Delegate
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    NSRange textRange = [textView selectedRange];
    if (textRange.length ==0 || textRange.location > textView.text.length) {
        return; 
    }
    NSString *selectedString = [textView.text substringWithRange:textRange];
    NSLog(@"The selected String is %@",selectedString);
}

#pragma mark - Gesture Recongnizer

- (void)singleTapRecognized:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [UIMenuController sharedMenuController].menuVisible = NO;
    CGPoint tapLocation = [tapGestureRecognizer locationInView:self.view];

    UITextRange *textRange = [self.textView selectedTextRange];
    CGRect selectionStartRect = [self.textView caretRectForPosition:textRange.start];
    CGRect selectionEndRect = [self.textView caretRectForPosition:textRange.end];
    
    // rect of the selected text
    CGRect selectedTextRect = CGRectMake(selectionStartRect.origin.x, selectionStartRect.origin.y, selectionEndRect.origin.x - selectionStartRect.origin.x - selectionStartRect.size.width, selectionStartRect.origin.x + selectionStartRect.size.height);
    if (CGRectContainsPoint(selectedTextRect, tapLocation)) {
        NSRange textRange = [self.textView selectedRange];
        if (textRange.length ==0 || textRange.location > self.textView.text.length) {
            return;
        }
        NSString *selectedString = [self.textView.text substringWithRange:textRange];
        NSLog(@"The selected String is %@",selectedString);
    }
    
    
    NSLog(@"x = %f , y = %f", tapLocation.x, tapLocation.y );
}
@end
