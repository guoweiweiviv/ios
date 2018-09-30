//
//  Table2+CoreDataProperties.h
//  coreData
//
//  Created by gnway on 2018/9/30.
//  Copyright © 2018年 com.gnway. All rights reserved.
//
//

#import "Table2+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Table2 (CoreDataProperties)

+ (NSFetchRequest<Table2 *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *xxx;

@end

NS_ASSUME_NONNULL_END
