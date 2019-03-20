//
//  XYcollectionViewCell.m
//  collectionViewTest
//
//  Created by gnway on 2018/11/16.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYcollectionViewCell.h"

@interface XYcollectionViewCell ()
@property IBOutlet UIButton *imgBtn;
@property IBOutlet UIButton *delBtn;
- (IBAction) imgBtnPressed:(id)sender;
-(IBAction) deleBtnPress:(id)sender;
@end

@implementation XYcollectionViewCell

-(id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  return self;
}

-(void) awakeFromNib
{
  [super awakeFromNib];
  
   [self.imgBtn setBackgroundColor:[UIColor redColor]];
}

//清理数据
-(void) prepareForReuse
{
  [super prepareForReuse];
}

-(void) configCell:(NSDictionary *)data
{
  NSIndexPath *indexPath = [data objectForKey:@"indexPath"];
  if (indexPath) {
    [self.imgBtn setTitle:[NSString stringWithFormat:@"%d", indexPath.row] forState:UIControlStateNormal];
  }
}

- (IBAction) imgBtnPressed:(id)sender
{
  NSLog(@"imgBtnPressed");
}

-(IBAction) deleBtnPress:(id)sender
{
  
}

@end
