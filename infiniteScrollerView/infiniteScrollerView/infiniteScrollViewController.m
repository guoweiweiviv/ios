//
//  infiniteScrollerViewController.m
//  infiniteScrollerView
//
//  Created by gnway on 2018/12/18.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "infiniteScrollViewController.h"
@interface infinteScrollViewController () <UIScrollViewDelegate>
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIButton *leftBtn;
@property (nonatomic) UIButton *midBtn;
@property (nonatomic) UIButton *rightBtn;

@property NSInteger currentIndex;
@property NSInteger totalCount;
@end

@implementation infinteScrollViewController

-(id) init
{
  self = [super init];
  return self;
}

-(void) viewDidLoad
{
  CGSize ss = [UIScreen mainScreen].bounds.size;
  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ss.width, ss.height)];
  self.leftBtn = [[UIButton   alloc ] initWithFrame:CGRectMake(0, 0, ss.width, ss.height)];
  self.midBtn = [[UIButton   alloc ] initWithFrame:CGRectMake(ss.width, 0, ss.width, ss.height)];
  self.rightBtn = [[UIButton   alloc ] initWithFrame:CGRectMake(ss.width*2, 0, ss.width, ss.height)];
  [self.scrollView setContentSize:CGSizeMake(ss.width*3, ss.height)];
  [self.scrollView setContentOffset:CGPointMake(ss.width, 0)];
  [self.scrollView setPagingEnabled:YES];
  self.scrollView.delegate = self;
  self.currentIndex = 0;
  self.totalCount = 100;
  [self.scrollView addSubview:self.leftBtn];
  [self.scrollView addSubview:self.midBtn];
  [self.scrollView addSubview:self.rightBtn];
  [self.view addSubview:self.scrollView];
}

-(void) viewWillAppear:(BOOL)animated
{
  [self setBtnByIndex:0];
}

-(void) setBtnByIndex:(NSInteger) index;
{
  NSArray *btns = @[self.leftBtn, self.midBtn, self.rightBtn];
  for (NSInteger i=0; i<3; i++) {
    NSInteger ii = (i-1+index+self.totalCount) %  self.totalCount;
    
    UIButton *btn = [btns objectAtIndex:i];
    NSString *title = [NSString stringWithFormat:@"--- %ld ---", (long)ii];
    [btn setTitle:title forState:UIControlStateNormal];
  }
}

-(void) refreshBtns
{
  CGSize ss = [UIScreen mainScreen].bounds.size;
  
  if (self.scrollView.contentOffset.x>ss.width) {
    self.currentIndex=((self.currentIndex+1)%self.totalCount);
  } else if(self.scrollView.contentOffset.x<ss.width){
    self.currentIndex=((self.currentIndex-1+self.totalCount)%self.totalCount);
  }
  [self setBtnByIndex:self.currentIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  [self refreshBtns];
  CGSize ss = [UIScreen mainScreen].bounds.size;
  self.scrollView.contentOffset = CGPointMake(ss.width,0);
  
//  NSLog(@"停止了加速,停在第%d页",self.pageControl.currentPage+1);
}
@end
