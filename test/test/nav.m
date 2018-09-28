//
//  nav.m
//  test
//
//  Created by gnway on 2018/9/11.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "nav.h"

@interface nav () <UIGestureRecognizerDelegate, UIViewControllerRestoration>
@end

@implementation nav

-(void) viewDidLoad
{
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor redColor]];
  self.interactivePopGestureRecognizer.enabled = YES;
  [self.navigationBar setHidden:YES];
  
  self.restorationIdentifier  = NSStringFromClass([self class]);
  self.restorationClass = [self class];
}

- (void) encodeRestorableStateWithCoder:(NSCoder *)coder {
  [super encodeRestorableStateWithCoder:coder];
}

- (void) decodeRestorableStateWithCoder:(NSCoder *)coder{
  [super decodeRestorableStateWithCoder:coder];
}

+ (UIViewController *) viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
                                                             coder:(NSCoder *)coder
{
  nav *nv = [[nav alloc] init];
  nv.restorationIdentifier  = NSStringFromClass([nav class]);
  nv.restorationClass = [nav class];
  
  //构建rootViewController 时，需要显示它，否则，可能后续的viewcontorller 可能 presentViewController 失败
  [[UIApplication sharedApplication] delegate].window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [[UIApplication sharedApplication] delegate].window.backgroundColor = [UIColor greenColor];
  [[[UIApplication sharedApplication] delegate].window makeKeyAndVisible];
  [[UIApplication sharedApplication] delegate].window.rootViewController = nv;
  return nv;
}

-(void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  if (self.viewControllers.count <= 1 ) {
    return NO;
  }
  return YES;
}

-(void) viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  NSLog(@"nav will disappear!");
}

// 允许同时响应多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
}

-(void) dealloc
{
  NSLog(@"dealloc nav");
}

@end
