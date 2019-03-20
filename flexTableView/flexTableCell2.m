//
//  flexTableCell2.m
//  flexTableView
//
//  Created by gnway on 2018/12/12.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "flexTableCell2.h"

@interface flexTableCell2 ()
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *flagLabel;
@end


@implementation flexTableCell2
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  self.leftMargin = 20.0f;
  self.rightMargin = 20.0f;
  self.midMargin = 20.0f;
  self.height = 43.5f;
  
  return self;
}

-(void) configCell:(NSDictionary *)content
{
  [self.contentView setAutoresizesSubviews:NO];
  CGSize ss = [UIScreen mainScreen].bounds.size;
  
  CGFloat tw = (ss.width - self.leftMargin - self.rightMargin - self.midMargin) * 0.5f;
  
  self.titleLabel = [self.contentView viewWithTag:2];
  if (self.titleLabel == nil) {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin, 0, tw, self.height)];
    self.titleLabel.numberOfLines = 0;
     self.titleLabel.translatesAutoresizingMaskIntoConstraints  = NO;
   
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.tag = 2;
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:self.titleLabel];
    
    
    [[NSLayoutConstraint constraintWithItem:self.contentView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel  attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.contentView  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual   toItem:self.titleLabel  attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f] setActive:YES];
    
//    //高度限制
    [[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.height] setActive:YES];
    
//    //宽度限制
   [[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:tw] setActive:YES];
    
    //Y轴内容压缩限制
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow-1 forAxis:UILayoutConstraintAxisHorizontal];
    
    //X轴内容吸附
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow-1 forAxis:UILayoutConstraintAxisVertical];
  }
  
  self.flagLabel = [self.contentView viewWithTag:3];
  if (self.flagLabel == nil) {
    self.flagLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin+tw, 0, self.midMargin, self.height)];
    self.flagLabel.tag = 3;
    self.flagLabel.text = @"*";
    [self.flagLabel setTextColor:[UIColor redColor]];
    [self.contentView addSubview:self.flagLabel];
    
    self.flagLabel.translatesAutoresizingMaskIntoConstraints  = NO;
    [[NSLayoutConstraint constraintWithItem:self.flagLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f] setActive:YES];
  }
  
  NSString *title = @"超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长";
 // NSString *title = @"很短";
  [self.titleLabel setText:title];
}
@end
