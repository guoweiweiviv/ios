//
//  rightMenuVC.m
//  test
//
//  Created by gnway on 2018/9/19.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "leftMenuVC.h"
#import "interactiveAT.h"

@interface leftMenuVC  () <UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (nonatomic) UITapGestureRecognizer *tapGest;
@property (nonatomic) UIScreenEdgePanGestureRecognizer *leftGest;
@property (nonatomic) interactiveAT *iat;

@property (nonatomic) UIView *contentView;
@end

@implementation leftMenuVC

-(id) init
{
  self = [super init];
  self.modalPresentationCapturesStatusBarAppearance = YES;
  
  __weak typeof(self) weakSelf = self;
  self.transitioningDelegate = weakSelf;
  self.modalPresentationStyle = UIModalPresentationOverFullScreen;
  return self;
}

-(void) viewDidLoad
{
  [super viewDidLoad];
  self.modalPresentationStyle = UIModalPresentationOverFullScreen;
  [self.view setBackgroundColor:[UIColor clearColor]];
  
  _iat = [[interactiveAT alloc] init];
  _iat.isInteractive = NO;
  [self makeGesture];
  
  CGSize ss = [UIScreen mainScreen].bounds.size;
  _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ss.width * 0.8, ss.height)];
  [self.view addSubview:_contentView];
  [_contentView setBackgroundColor:[UIColor blueColor]];
}

//手势
-(void) makeGesture
{
  _leftGest = [[UIScreenEdgePanGestureRecognizer alloc] init];
  _leftGest.delegate = self;
  _leftGest.edges = UIRectEdgeLeft;
  [_leftGest addTarget:self action:@selector(gestureAction:)];
  [self.view addGestureRecognizer:_leftGest];
  
  _tapGest = [[UITapGestureRecognizer alloc] init];
  [_tapGest setNumberOfTapsRequired:1];
  _tapGest.delegate = self;
  [_tapGest addTarget:self action:@selector(dismiss:)];
  [self.view addGestureRecognizer:_tapGest];
}

-(void) gestureAction:(id)sender
{
  UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)sender;
  CGPoint pp = [gesture translationInView:self.view];
  CGSize ss = [UIScreen mainScreen].bounds.size;
  CGFloat persent = pp.x / ss.width;
  switch (gesture.state) {
    case UIGestureRecognizerStateBegan:
      [self dismissViewControllerAnimated:YES completion:nil];
      break;
    case UIGestureRecognizerStateChanged:
      [_iat updateInteractiveTransition:persent];
      break;
    case UIGestureRecognizerStateEnded:
      if (persent > 0.6)
        [_iat finishInteractiveTransition];
      else {
        [_iat cancelInteractiveTransition];
      }
      break;
    case UIGestureRecognizerStateCancelled:
      [_iat cancelInteractiveTransition];
      break;
    case UIGestureRecognizerStateFailed:
      break;
    default:
      break;
  }
}

-(void) dismiss:(id)sender
{
  CGSize ss = [UIScreen mainScreen].bounds.size;
  CGPoint pp = [_tapGest locationInView:_contentView];
  if (pp.x < ss.width * 0.8)
    return ;
  [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
  if ([gestureRecognizer isEqual:_leftGest])
    _iat.isInteractive = YES;
  return YES;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
  return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
  return self;
}

//交互转场动画
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
  return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
  if ( _iat.isInteractive)
    return _iat;
  return nil;
}


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
  // return _ti;
  return 0.5;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
  UIViewController  *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController  *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  if ([fromVC isEqual:self]) {
    //pop
    //container 已经包含了fromView
    UIView *container = transitionContext.containerView ;
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    CGSize ss = [UIScreen mainScreen].bounds.size;
    
    UIView *temp_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ss.width+ss.width*0.8, ss.height)];
    UIView *rightView  = [toView snapshotViewAfterScreenUpdates:NO];
    UIView *leftView = [fromView snapshotViewAfterScreenUpdates:NO];
    [leftView setFrame:CGRectMake(0, 0, ss.width, ss.height)];
    [rightView setFrame:CGRectMake(ss.width*0.8, 0, ss.width, ss.height)];
    [temp_view addSubview:rightView];
    [temp_view addSubview:leftView];
    [container addSubview:temp_view];
    
    [temp_view setFrame:CGRectMake(0, 0, ss.width+ss.width*0.8, ss.height)];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
      [temp_view setFrame:CGRectMake(-ss.width*0.8, 0, ss.width+ss.width*0.8, ss.height)];
      
      [toView setFrame:CGRectMake(0, 0, ss.width, ss.height)];
 //     [toView setFrame:CGRectMake(0, 0, ss.width, ss.width)];
    } completion:^(BOOL finished) {
  //    [temp_view removeFromSuperview];
      
      bool flag = [transitionContext transitionWasCancelled];
      [transitionContext completeTransition:!flag];
      
    } ];
  } else {
    //push
    UIView *container = transitionContext.containerView ;
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    CGSize ss = [UIScreen mainScreen].bounds.size;
    [container addSubview:toView];
    
    [toView setFrame:CGRectMake(ss.width, 0, ss.width, ss.height)];
    [fromView setFrame:CGRectMake(0, 0, ss.width, ss.height)];
    
    UIView *temp_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ss.width+ss.width*0.8, ss.height)];
    UIView *rightView  = [fromView snapshotViewAfterScreenUpdates:NO];
    UIView *leftView = [toView snapshotViewAfterScreenUpdates:YES];
    [leftView setFrame:CGRectMake(0, 0, ss.width, ss.height)];
    [rightView setFrame:CGRectMake(ss.width*0.8, 0, ss.width, ss.height)];
    [temp_view addSubview:rightView];
    [temp_view addSubview:leftView];
    [container addSubview:temp_view];
    [temp_view setFrame:CGRectMake(-ss.width*0.8, 0, ss.width+ss.width*0.8, ss.height)];
   
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
      [temp_view setFrame:CGRectMake(0, 0, ss.width+ss.width*0.8, ss.height)];
      
      [fromView setFrame:CGRectMake(ss.width*0.8, 0, ss.width, ss.height)];
      [toView setFrame:CGRectMake(0, 0, ss.width, ss.height)];
    } completion:^(BOOL finished) {
      [temp_view removeFromSuperview];
      
      bool flag = [transitionContext transitionWasCancelled];
      [transitionContext completeTransition:!flag];
      
    } ];
  }
}

@end
