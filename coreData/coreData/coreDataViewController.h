//
//  coreDataViewController.h
//  coreData
//
//  Created by gnway on 2018/9/29.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#ifndef coreDataViewController_h
#define coreDataViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface coreDataViewController : UITableViewController
//浅拷贝
@property (nonatomic, copy) NSMutableDictionary *dict;
@end

#endif /* coreDataViewController_h */
