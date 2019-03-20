//
//  multiDismensionArrayVC.m
//  BangYa+XMPP
//
//  Created by gnway on 2018/11/26.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "flexHeightButton.h"
#import "flexTableCell.h"
#import "multiDismensionArrayVC.h"

@interface multiDismensionArrayVC () <UITableViewDelegate, UITableViewDataSource>
@property IBOutlet flexHeightButton *arr0Btn;
@property IBOutlet flexHeightButton *arr1Btn;
@property IBOutlet flexHeightButton *arr2Btn;
@property IBOutlet flexHeightButton *arr3Btn;
@property IBOutlet flexHeightButton *arr4Btn;

@property IBOutlet UITableView *tableView;

@end

@implementation multiDismensionArrayVC

-(id) init
{
  self = [super initWithNibName:@"multiDismensionArrayVC" bundle:nil];
  return self;
}

-(void) viewDidLoad
{
  [super viewDidLoad];
  [self.navigationController.navigationBar setTranslucent:NO];
  [self makeBtnsConstraint];
  
  self.tableView.estimatedRowHeight = 43.5;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  UINib *nib = [UINib nibWithNibName:@"flexTableCell" bundle:nil];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"flexTableCell"];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

-(void) makeBtnsConstraint
{
  CGSize ss = [UIScreen mainScreen].bounds.size;
  CGFloat w = ss.width / 5.0f;
  CGFloat h = 200.0f;
  
  [[NSLayoutConstraint constraintWithItem:self.arr0Btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:w] setActive:YES];
  
  [[NSLayoutConstraint constraintWithItem:self.arr1Btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:w] setActive:YES];
  [[NSLayoutConstraint constraintWithItem:self.arr2Btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:w] setActive:YES];
  [[NSLayoutConstraint constraintWithItem:self.arr3Btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:w] setActive:YES];

  [[NSLayoutConstraint constraintWithItem:self.arr4Btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:w] setActive:YES];
  
  [[NSLayoutConstraint constraintWithItem:self.arr0Btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:h] setActive:YES];
  
  [[NSLayoutConstraint constraintWithItem:self.arr1Btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:h] setActive:YES];
  [[NSLayoutConstraint constraintWithItem:self.arr2Btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:h] setActive:YES];
  [[NSLayoutConstraint constraintWithItem:self.arr3Btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:h] setActive:YES];
  
  [[NSLayoutConstraint constraintWithItem:self.arr4Btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:h] setActive:YES];

  
  [self.view updateConstraintsIfNeeded];
}


-(IBAction)arrBtnPressed:(id)sender
{
  UIButton *btn = (UIButton *)sender;
  flexHeightButton *fhBtn = (flexHeightButton *)btn.superview;
  NSString *txt = fhBtn.label.text;
  NSString *newTxt = [NSString stringWithFormat:@"%@%@", txt, txt];
  [fhBtn setTitle:newTxt];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  flexTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"flexTableCell"];
  [cell.txtLabel setText:@"xx\nxx\nXX"];
  return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  flexTableCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
  [cell selectMe:YES];
}
@end
