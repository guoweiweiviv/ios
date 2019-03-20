//
//  flexTableCell2.m
//  flexTableView
//
//  Created by gnway on 2018/12/12.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "flexTableCell3.h"

@interface flexTableCell3 ()
@property (nonatomic) UIButton *cellBtn;
@end


@implementation flexTableCell3

-(void) configCell:(NSDictionary *)content
{
//  [super configCell:content];  
  CGSize ss = [UIScreen mainScreen].bounds.size;
  
  NSString *str = @"超长按钮超长按钮超长按钮超长按钮超长按钮超长按钮超长按钮超长按钮超长按钮超长按钮";

  CGFloat tw = (ss.width - self.leftMargin - self.rightMargin - self.midMargin) * 0.5f;

  self.cellBtn = [self.contentView viewWithTag:4];
  if (self.cellBtn == nil) {
    self.cellBtn = [[UIButton alloc] initWithFrame:CGRectMake(ss.width-self.rightMargin-tw, 0, tw, self.height)];
    self.cellBtn.tag = 4;
    [self.cellBtn setTitleEdgeInsets:UIEdgeInsetsZero];
    [self.cellBtn  setTitle:str forState:UIControlStateNormal];
    self.cellBtn.titleLabel.numberOfLines = 0;
    self.cellBtn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.cellBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //  [self.cellBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    //  [self.cellBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.contentView addSubview:self.cellBtn];
    
    [self.cellBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //高度限制
    [[NSLayoutConstraint constraintWithItem:self.cellBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.height] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.cellBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.cellBtn.titleLabel attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f] setActive:YES];
    
    //宽度限制
    [[NSLayoutConstraint constraintWithItem:self.cellBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:tw] setActive:YES];
    
    [self.cellBtn.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.cellBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.cellBtn setContentCompressionResistancePriority:UILayoutPriorityDefaultLow-1 forAxis:UILayoutConstraintAxisHorizontal];
    
    [[NSLayoutConstraint constraintWithItem:self.cellBtn  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView   attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.cellBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView  attribute:NSLayoutAttributeRight multiplier:1.0f constant:-1 * self.rightMargin] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.contentView  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.cellBtn  attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f] setActive:YES];;


  } else {
     [self.cellBtn  setTitle:str forState:UIControlStateNormal];
    [self.cellBtn  invalidateIntrinsicContentSize ];
    [self.cellBtn  setNeedsUpdateConstraints];
    [self.cellBtn  updateConstraintsIfNeeded];
  }
  
//    NSString *str = @"超长按钮超长按钮超长按钮超长按钮超长按钮超长按钮超长按钮超长按钮超长按钮超长按钮";
//    if (str && [str isKindOfClass:[NSString class]]) {
//      [self.cellBtn  setTitle:str forState:UIControlStateNormal];
//
//      [self.cellBtn  invalidateIntrinsicContentSize ];
//      [self.cellBtn  setNeedsUpdateConstraints];
//      [self.cellBtn  updateConstraintsIfNeeded];
//
//    }
}
@end
