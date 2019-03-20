//
//  XYUIScollView.m
//  TableViewRefresh
//
//  Created by gnway on 2019/3/15.
//  Copyright © 2019年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYUIScrollView.h"

@interface XYUIScrollView ()
@property (nonatomic) UIScrollView *insideScrollView;
@end

@implementation XYUIScrollView

-(id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  CGSize size = frame.size;
  self.insideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
  [self addSubview:self.insideScrollView];
}

-(void) addSubview:(UIView *)view
{
  self.insideScrollView addSubview:<#(nonnull UIView *)#>
}
@end
