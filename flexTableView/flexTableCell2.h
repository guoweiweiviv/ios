//
//  flexTableCell2.h
//  flexTableView
//
//  Created by gnway on 2018/12/12.
//  Copyright © 2018年 com.gnway. All rights reserved.
//

#ifndef flexTableCell2_h
#define flexTableCell2_h
#import <UIkit/UIkit.h>

@interface flexTableCell2 : UITableViewCell
-(void) configCell:(NSDictionary *)content;

@property CGFloat leftMargin;
@property CGFloat rightMargin;
@property CGFloat midMargin;
@property CGFloat height;
@end

#endif /* flexTableCell2_h */
