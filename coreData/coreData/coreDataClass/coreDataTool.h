//
//  coredataTools.h
//  coredata
//
//  Created by gnway on 2018/3/16.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#ifndef coreDataTools_h
#define coreDataTools_h

#import <CoreData/CoreData.h>


@interface coreDataTool : NSObject

+(instancetype) curCoreDataTool;

//modelName  模型文件名
// storeFilePath 数据库文件保存名
-(void) loadDB:(NSString *)modelName stroeFilePath:(NSString *)storeFilePath;

//等待正在执行的操作完成，然后关闭数据库
-(void) closeDB;

//等待正在执行的操作完成，然后关闭数据库
-(void) closeDBWithResult:(void (^)(NSError *))completion;
//多线程异步执行
//(bool (^)(NSManagedObjectContext *))handle 返回值表示是否需要保存
-(void) dbActionBG:(bool (^)(NSManagedObjectContext *))handle;

//在同一个线程中，异步执行
//即所有操作在同一非主线程中，同步的执行
-(void) dbActionBGOnSameThread:(bool (^)(NSManagedObjectContext *))handle;

//在当前线程中同步执行
//(bool (^)(NSManagedObjectContext *))handle 返回值表示是否需要保存
-(void) dbActionWait:(bool (^)(NSManagedObjectContext *))handle;

@end

#endif /* coredataTools_h */
