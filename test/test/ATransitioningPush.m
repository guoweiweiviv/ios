//
//  ATransitioning.m
//  test
//
//  Created by gnway on 2018/9/13.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATransitioningPush.h"

@implementation ATransitioningPush


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
  return _ti;
//  return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
  UIViewController  *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController  *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  UIView *container = transitionContext.containerView ;
  [container addSubview:toVC.view];
  
  CGSize ss = [UIScreen mainScreen].bounds.size;
  CGSize fromSize = fromVC.view.frame.size;
  CGSize toSize = toVC.view.frame.size;
  
  [fromVC.view setFrame:CGRectMake(0, 0, fromSize.width, fromSize.height)];
  [toVC.view setFrame:CGRectMake(ss.width, 0, toSize.width, toSize.height)];
  
  [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
    [fromVC.view setFrame:CGRectMake(-ss.width, 0, fromSize.width, fromSize.height)];
    [toVC.view setFrame:CGRectMake(0, 0, toSize.width, toSize.height)];
  } completion:^(BOOL finished) {
    bool flag = [transitionContext transitionWasCancelled];
    [transitionContext completeTransition:!flag];    
  } ];
}
@end
