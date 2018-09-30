//
//  Table1+CoreDataProperties.m
//  coreData
//
//  Created by gnway on 2018/9/30.
//  Copyright © 2018年 com.gnway. All rights reserved.
//
//

#import "Table1+CoreDataProperties.h"

@implementation Table1 (CoreDataProperties)

+ (NSFetchRequest<Table1 *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Table1"];
}

@dynamic item1;
@dynamic item2;
@dynamic relationship;
@dynamic relationship1;

@end
