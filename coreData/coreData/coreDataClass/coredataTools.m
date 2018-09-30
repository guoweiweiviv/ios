//
//  coredataTools.m
//  coredata
//
//  Created by gnway on 2018/3/16.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "coredataTools.h"

static coredataTools *tools;
static void (^static_complete)(NSError *);

@interface coredataTools ()
@property (atomic) NSPersistentStore *store;
@property (atomic) NSPersistentStoreCoordinator *stroeContainer;

@property (atomic) NSManagedObjectModel *model;
//主上下文
@property (atomic) NSManagedObjectContext *mainContext;
//子上下文,用来执行同一线程的异步操作
//也可执行同步操作
@property (atomic) NSManagedObjectContext *oneSubContext;
//子上下文合集，用来在不同线程中，异步执行操作
@property (atomic) NSMutableArray *contextArr;
@property bool lock;
@end

@implementation coredataTools

+(instancetype) sharedInstance
{
  if (tools == nil) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      tools = [[coredataTools alloc] init];
    });
  }
  return tools;
}


-(id) init
{
  self = [super init];
  self.store = nil;
  self.stroeContainer = nil;
  self.mainContext = nil;
  self.lock = YES;
  return self;
}

-(void) loadDB:(NSString *)modelName stroeFilePath:(NSString *)storeFilePath;
{
  if ([self isOpened])
    return ;
  
  //模型
  NSURL *modeFile = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
  _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modeFile];
  
  //持久化代理
  _stroeContainer = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
  
  
  //coredata 上下文
  _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  
  [_mainContext setPersistentStoreCoordinator:_stroeContainer];
  
  
  //数据库文件保存
  NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                           [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
  
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  NSURL *storeURL = [documentsURL URLByAppendingPathComponent:storeFilePath];
  
  NSError *err = nil;
  //数据文件保存路径
  self.store = [self.stroeContainer addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&err];
  
  self.lock = NO;
  self.contextArr = [[NSMutableArray alloc] init];
  if (err)
    NSLog(@"%@", err);
}

-(void) closeDBWithResult:(void (^)(NSError *))completion
{
  if (![self isOpened]) {
   if (completion)
     completion(nil);
    return;
  }
  
  @synchronized (self) {
    self.lock = YES;
  }
  
  //检查多线程的任务
  if ([self.contextArr count] > 0) {
    static_complete = completion;
    [self addObserver:self forKeyPath:@"contextArr" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    return;
  }
  
  __weak typeof(self) weakSelf = self;
  [self.oneSubContext performBlock:^{
    weakSelf.oneSubContext = nil;
    weakSelf.store = nil;
    weakSelf.stroeContainer = nil;
    weakSelf.mainContext = nil;
    if (completion)
      completion(nil);
  }];
}

-(void) closeDB
{
  if (![self isOpened])
    return;
  
  @synchronized (self) {
    self.lock = YES;
  }
  
  //检查多线程的任务
  if ([self.contextArr count] > 0) {
  
    [self addObserver:self forKeyPath:@"contextArr" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    return;
  }
  
  __weak typeof(self) weakSelf = self;
  [self.oneSubContext performBlock:^{
    weakSelf.oneSubContext = nil;
    weakSelf.store = nil;
    weakSelf.stroeContainer = nil;
    weakSelf.mainContext = nil;
  }];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context
{
  __weak typeof(self) weakSelf = self;
  if ([self.contextArr count] == 0) {
    [self.oneSubContext performBlock:^{
      weakSelf.oneSubContext = nil;
      weakSelf.store = nil;
      weakSelf.stroeContainer = nil;
      weakSelf.mainContext = nil;
    }];
    [self removeObserver:self forKeyPath:keyPath];
    if (static_complete) {
      static_complete(nil);
      static_complete = nil;
    }
  }
}


-(void) dealloc
{
  [self closeDB];
}

-(BOOL) isOpened
{
  if (_store == nil
      || _stroeContainer == nil
      || _mainContext == nil) {
    NSLog(@"db do not loaded!");
    return false;
  }
  return true;
}

//需要重新创建一个子上下文，
//子上下文件中会将创建queue, pperformBlock 将在非主线程中异步执行
//使用观察队列来确定确定异步操作全部完成
-(void) dbActionBG:(bool (^)(NSManagedObjectContext *))handle;
{
  NSManagedObjectContext *subContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  [subContext setParentContext:_mainContext];
  __weak typeof(self) weakSelf = self;
  @synchronized(self) {
    if (self.lock)
      return;
    else {
      [self.contextArr addObject:subContext];
    }
  }
  
  //test
  [subContext performBlock:^{
    if (handle) {
      handle(subContext);
    }
    
    @synchronized (self) {
 //     [weakSelf.contextArr removeObject:subContext];
      //kvo 代理
      [[weakSelf mutableArrayValueForKey:@"contextArr"] removeObject:subContext];
    }
  }];
}

-(void) dbActionBGA:(bool (^)(NSManagedObjectContext *))handle
{
  @synchronized(self) {
    if (self.lock)
      return;
  }
  
  if (_oneSubContext == nil) {
    _oneSubContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [_oneSubContext setParentContext:_mainContext];
  }
  
  //test
  [_oneSubContext performBlock:^{
    if (handle) {
      handle(self.oneSubContext);
    }
  }];
}

//需要重新创建一个子上下文，
//performBlockAndWait 会在当前线程中同步执行操作
-(void) dbActionWait:(bool (^)(NSManagedObjectContext *))handle
{
  @synchronized(self) {
    if (self.lock)
      return;
  }
  
  [self.oneSubContext performBlockAndWait:^{
    if (handle) {
      if (handle(self.oneSubContext)) {
        [self.mainContext performBlockAndWait:^{
          NSError *err = nil;
          if (![self.mainContext save:&err])
            NSLog(@"%@", err);
        }];
      }
    }
  }];
}

@end
