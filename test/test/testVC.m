//
//  testVC.m
//  test
//
//  Created by gnway on 2018/9/10.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATransitioningPush.h"
#import "ATransitioningPop.h"
#import "interactiveAT.h"
#import "testVC.h"
#import "rightMenuVC.h"
#import "leftMenuVC.h"
#import "tableView.h"
#import "tableViewController.h"

@interface testVC ()  <UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate, UIViewControllerRestoration>
@property (nonatomic) UINavigationBar *navBar;
@property (nonatomic) UIScreenEdgePanGestureRecognizer *gesture;
@property (nonatomic) interactiveAT *iat;
@property bool isRestore;
@end

@implementation testVC

-(UIStatusBarStyle)preferredStatusBarStyle
{
  if (_i % 2 == 0)
    return UIStatusBarStyleLightContent;
  else
    return UIStatusBarStyleDefault;
}

-(id) init
{
  self = [super init];
  self.modalPresentationCapturesStatusBarAppearance = YES;
  __weak typeof(self) weakSelf = self;
  self.transitioningDelegate = weakSelf;
  self.modalPresentationStyle = UIModalPresentationOverFullScreen;
  self.isRestore = NO;
  return self;
}

-(void) viewDidLoad
{
  [super viewDidLoad];
  NSLog(@"%@", self);
  
  self.restorationClass = [testVC class];
  self.restorationIdentifier = NSStringFromClass([testVC class]);
  
  [self makeNavBtn];
  [self presentBtn];
  [self leftMenuBtn];
  
  _iat = [[interactiveAT alloc] init];
  _iat.isInteractive = NO;
  [self makeGesture];
  

}

-(void) presentBtn
{
  UIButton *btn = [self.view viewWithTag:100];
  if (btn == nil) {
    btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 90, 50, 40)];
    btn.tag = 100;
    NSString *str = [NSString stringWithFormat:@"%d", _i];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushNewView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
  }
}

-(void)leftMenuBtn
{
  UIButton *btn = [self.view viewWithTag:101];
  if (btn == nil) {
    btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 90, 50, 40)];
    btn.tag = 101;
    NSString *str = [NSString stringWithFormat:@"left menu"];
    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushLeftMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
  }
}

-(void) pushLeftMenu:(id)sender
{
  leftMenuVC *vc = [[leftMenuVC alloc] init];
  vc = nil;
  [self presentViewController:vc animated:YES completion:nil];
}

-(void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
//   NSLog(@"111 %@", self);
  
  if (_i % 2 == 0)
    [self.view setBackgroundColor:[UIColor whiteColor]];
  else
    [self.view setBackgroundColor:[UIColor grayColor]];
  
  UIButton *btn = [self.view viewWithTag:100];
  if (btn) {
    NSString *str = [NSString stringWithFormat:@"%d", _i];
    [btn setTitle:str forState:UIControlStateNormal];
  }
}

-(void) viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
 //  NSLog(@"222 %@", self);
  NSLog(@"%@", self.presentingViewController);
}

- (void) encodeRestorableStateWithCoder:(NSCoder *)coder {
  [super encodeRestorableStateWithCoder:coder];
  [coder encodeObject:[NSNumber numberWithInteger:_i] forKey:@"ii"];
}

- (void) decodeRestorableStateWithCoder:(NSCoder *)coder{
  [super decodeRestorableStateWithCoder:coder];
 // self.messageInput.text = [coder decodeObjectForKey:kMessageRestorationKey];
  _i = [[coder decodeObjectForKey:@"ii"] integerValue];

}

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
  NSNumber *num =  [coder decodeObjectForKey:@"ii"];
  if (num == nil) {
    return nil;
  }
  testVC* vc = [[testVC alloc] init];
  vc.restorationIdentifier = NSStringFromClass([testVC class]);
  vc.restorationClass = [testVC class];
  vc.isRestore = YES;
  return vc;
}

- (void) applicationFinishedRestoringState
{
  NSLog(@"xxxx");
}

//手势
-(void) makeGesture
{
  _gesture = [[UIScreenEdgePanGestureRecognizer alloc] init];
  _gesture.delegate = self;
  _gesture.edges = UIRectEdgeLeft;
  [_gesture addTarget:self action:@selector(gestureAction:)];
  [self.view addGestureRecognizer:_gesture];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
  _iat.isInteractive = YES;
  return YES;
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

-(void) makeNavBtn
{
  CGSize ss = [UIScreen mainScreen].bounds.size;
  UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, ss.width, 44)];
  
  UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
  UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"test"];
  item.leftBarButtonItem = back;
  UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"打开" style:UIBarButtonItemStylePlain target:self action:@selector(openNewView:)];
  item.rightBarButtonItem = rightBtn;
  [navBar setItems:@[item]];
  [self.view addSubview:navBar];
}

-(void) openNewView:(id)sender
{
//  CGSize ss = [UIScreen mainScreen].bounds.size;
//  tableView* tview = [[tableView alloc] initWithFrame:CGRectMake(0, 0, ss.width*0.8f, ss.height) style:UITableViewStylePlain ];
  
//  tableViewController *tvc = [[tableViewController alloc] init];
  
  rightMenuVC *vc = [[rightMenuVC alloc] init];
  [self presentViewController:vc animated:YES completion:nil];
}

-(void) back:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) pushNewView:(id)sender
{
  testVC *newVC = [[testVC alloc] init];
  newVC.i = _i + 1;
  [self presentViewController:newVC animated:YES completion:nil];
}

-(void) dealloc
{
  NSLog(@"%d delloc", _i);
}

// 固定转场动画设置
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
  ATransitioningPush *ati = [[ATransitioningPush alloc] init];
  if (_isRestore)
    ati.ti = 0.0f;
  else
    ati.ti = 0.30f;
  
  return ati;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
  return [[ATransitioningPop alloc] init];
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

@end
