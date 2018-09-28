//
//  ATransitioning.m
//  test
//
//  Created by gnway on 2018/9/13.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATransitioningPop.h"

@implementation ATransitioningPop


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
  return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
  UIViewController  *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController  *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  
  //包含了 fromView
  UIView *container = transitionContext.containerView ;
  
  UIView *toView = toVC.view;
  UIView *fromView = fromVC.view;
  
  CGSize ss = [UIScreen mainScreen].bounds.size;
  
  [toView setFrame:CGRectMake(-ss.width, 0, ss.width, ss.height)];
  [fromView setFrame:CGRectMake(0, 0, ss.width, ss.height)];
  
  //这两种模式下，底下的 VC  已被移除
  if (transitionContext.presentationStyle != UIModalPresentationOverFullScreen && transitionContext.presentationStyle != UIModalPresentationOverCurrentContext) {
    [container addSubview:toView];
  }
  
  [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
    [fromView setFrame:CGRectMake(ss.width, 0, ss.width, ss.height)];
    [toView setFrame:CGRectMake(0, 0, ss.width, ss.height)];
  } completion:^(BOOL finished) {
    bool flag = [transitionContext transitionWasCancelled];
    [transitionContext completeTransition:!flag];
  } ];
}
@end
