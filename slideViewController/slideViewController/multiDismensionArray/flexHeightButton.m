//
//  flexHeightButton.m
//  slideViewController
//
//  Created by gnway on 2018/11/27.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "flexHeightButton.h"

@implementation flexHeightButton
-(id) init
{
  self = [super init];
  return self;
}

-(id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  return self;
}

-(void) setTitle:(NSString *)title
{
  [self.label setText:title];
}

@end
