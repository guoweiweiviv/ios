//
//  XYpageViewController.m
//  pageViewController
//
//  Created by gnway on 2019/2/25.
//  Copyright © 2019年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYpageViewController.h"

@interface XYpageViewController () <UIScrollViewDelegate>
@property (nonatomic) NSInteger viewCont;
@property (nonatomic) UIScrollView *s1;
@property (nonatomic) UIScrollView *s2;
@property (nonatomic) CGFloat s2BtnW;
@end

@implementation XYpageViewController

-(void) viewDidLoad
{
  [super viewDidLoad];
  self.viewCont = 4;
  self.s2BtnW = 80;
}

-(void) viewDidAppear:(BOOL)animated
{
  [self makeS1];
  [self makeS2];
}

-(void) makeS1
{
  CGSize ss = [[UIScreen mainScreen] bounds].size;
  self.s1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, ss.width, ss.height - 100)];
  [self.s1 setPagingEnabled:YES];
  for (NSInteger i=0; i<self.viewCont; i++) {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0 + ss.width * i, 0, ss.width, ss.height - 100)];
    [self.s1 addSubview:view];
    switch (i)
    {
      case 0:
      [view setBackgroundColor:[UIColor redColor]];
        break;
      case 1:
        [view setBackgroundColor:[UIColor blueColor]];
        break;
      case 2:
        [view setBackgroundColor:[UIColor grayColor]];
        break;
      case 3:
        [view setBackgroundColor:[UIColor greenColor]];
        break;
      case 4:
        [view setBackgroundColor:[UIColor blackColor]];
        break;
    }
  }
  [self.s1 setContentSize:CGSizeMake(ss.width * self.viewCont, ss.height - 100)];
  [self.view addSubview:self.s1];
  
   [self addObserver:self forKeyPath:@"s1.contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}


-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
  if ([keyPath isEqualToString:@"s1.contentOffset"]) {
    NSLog(@"%f", self.s1.contentOffset.x);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      CGFloat offset = [self s1Offset2S2Offset:self.s1.contentOffset.x];
      [self setllPosition:offset];
    });
  }
}


-(CGFloat) s1Offset2S2Offset:(CGFloat) xOffset
{
  CGSize ss = [[UIScreen mainScreen] bounds].size;
  CGFloat s2BtnMargin = (ss.width - self.viewCont *self.s2BtnW) / (self.viewCont  + 1);
  
  NSInteger curIndex = floorf(xOffset / ss.width);
  CGFloat offset_percentage = (xOffset - curIndex * ss.width) / ss.width;
  
  CGFloat s2Offset = s2BtnMargin + curIndex * (s2BtnMargin + self.s2BtnW) + offset_percentage *  (s2BtnMargin + self.s2BtnW) ;
  return s2Offset;
}

-(void) makeS2
{
  CGSize ss = [[UIScreen mainScreen] bounds].size;
  self.s2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, ss.width, 30)];
  [self.view addSubview:self.s2];
  UILabel *ll = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.s2BtnW, 20)];
  [ll setBackgroundColor:[UIColor orangeColor]];
  ll.tag = 99;
  [self.s2 addSubview:ll];
}

-(void) setllPosition:(CGFloat) xOffset
{
  UILabel *ll = [self.s2 viewWithTag:99];
  if (ll == nil)
    return;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    CGRect frame = ll.frame;
    frame.origin.x = xOffset;
    ll.frame = frame;
  });

}
@end
