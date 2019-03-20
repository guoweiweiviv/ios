//
//  flexTableCell.m
//  slideViewController
//
//  Created by gnway on 2018/11/28.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "flexTableCell.h"

@implementation flexTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  [self.textLabel setFont:[UIFont fontWithName:@"MicrosoftYaHei" size:15.0f]];
  [self.txtLabel setTextColor:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f]];
  return self;
}

-(void) selectMe:(BOOL)flag
{
  if (flag) {
    [self.txtLabel setTextColor:[UIColor colorWithRed:60.0f/255.0f green:158.0f/255.0f blue:250.0f/255.0f alpha:1.0f]];
  } else {
    [self.txtLabel setTextColor:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f]];

  }
}
@end
