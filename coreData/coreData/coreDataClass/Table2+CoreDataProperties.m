//
//  Table2+CoreDataProperties.m
//  coreData
//
//  Created by gnway on 2018/9/30.
//  Copyright © 2018年 com.gnway. All rights reserved.
//
//

#import "Table2+CoreDataProperties.h"

@implementation Table2 (CoreDataProperties)

+ (NSFetchRequest<Table2 *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Table2"];
}

@dynamic xxx;

@end
