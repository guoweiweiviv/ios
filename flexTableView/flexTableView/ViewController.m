//
//  ViewController.m
//  flexTableView
//
//  Created by gnway on 2018/11/9.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import "ViewController.h"
#import "table.h"
@interface ViewController ()
@property IBOutlet UILabel *label1;
@property IBOutlet UIButton *btn1;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}


-(void) viewDidAppear:(BOOL)animated
{
  CGSize ss = [UIScreen mainScreen].bounds.size;
  table *view = [[table alloc] initWithFrame:CGRectMake(0, 0, ss.width, ss.height) style:UITableViewStylePlain];
  [self.view addSubview:view];
  [view setBackgroundColor:[UIColor blueColor]];
 // view.scrollEnabled = NO;
 // [view setTranslatesAutoresizingMaskIntoConstraints:NO];

//  [[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:200] setActive:YES];
//  [[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:300] setActive:YES];
  
 // [[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0] setActive:YES];
 // [[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0] setActive:YES];
  
 // [view layoutIfNeeded];
//  CGSize size = view.contentSize;
//  NSLog(@"%f %f ", size.width, size.height);
//  vc.modalPresentationStyle = UIModalPresentationFullScreen;
//  [self presentViewController:vc animated:YES completion:nil];
  
  
//  [self.btn1 setTitle:@"超长超长超长超长超长超长超长超长超长超长超长超长超长" forState:UIControlStateNormal];
//  [self.btn1 invalidateIntrinsicContentSize ];
//  [self.btn1 updateConstraintsIfNeeded];
//  [self testLabel];
  
 // [self testTextView];
}

-(void) testLabel
{
  UIButton *label2 = [[UIButton alloc] initWithFrame:CGRectMake(150, 100, 60, 30)];
//  label2.layer.masksToBounds = YES;
  label2.layer.borderWidth = 1.0f;
   [self.view addSubview:label2];
  [label2 setTitleEdgeInsets:UIEdgeInsetsZero];
  label2.titleLabel.numberOfLines = 0;
  label2.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
  [label2 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
  [label2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];

  label2.translatesAutoresizingMaskIntoConstraints  = NO;
  [[NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:60] setActive:YES];
  
  [[NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:30.0f] setActive:YES];
  
  [[NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:label2.titleLabel attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f] setActive:YES];
  
  
// [label2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
  [label2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
   [label2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
  [label2 setTitle:@"超长超长超长超长超长超长超长超长超长超长超长超长超长" forState:UIControlStateNormal];
  [label2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [label2 invalidateIntrinsicContentSize ];
  [label2 setNeedsUpdateConstraints];
  [label2 updateConstraintsIfNeeded];
//  label2.lineBreakMode = NSLineBreakByTruncatingTail;

  [label2 addTarget:self action:@selector(changeTitle:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) changeTitle:(id)sender
{
  UIButton *btn = (UIButton *)sender;
  [btn setTitle:@"很短" forState:UIControlStateNormal];
  [btn invalidateIntrinsicContentSize ];
  [btn setNeedsUpdateConstraints];
  [btn updateConstraintsIfNeeded];
}

-(void) testTextView
{
  UITextView *label2 = [[UITextView alloc] initWithFrame:CGRectMake(150, 100, 60, 30)];
  label2.layer.borderWidth = 1.0f;
  [label2 setTextColor:[UIColor blackColor]];
  label2.text = @"超长超长超长超长超长超长超长超长超长超长超长超长超长";
  [self.view addSubview:label2];
  
  [label2 setScrollEnabled:NO];
  
  label2.translatesAutoresizingMaskIntoConstraints  = NO;
  [[NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:100] setActive:YES];
  [[NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:150] setActive:YES];
  [[NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:60] setActive:YES];
  
  [[NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:30.0f] setActive:YES];
  
  [label2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
  [label2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

@end
