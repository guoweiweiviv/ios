//
//  Table1+CoreDataProperties.h
//  coreData
//
//  Created by gnway on 2018/9/30.
//  Copyright © 2018年 com.gnway. All rights reserved.
//
//

#import "Table1+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Table1 (CoreDataProperties)

+ (NSFetchRequest<Table1 *> *)fetchRequest;

@property (nonatomic) int16_t item1;
@property (nullable, nonatomic, copy) NSString *item2;
@property (nullable, nonatomic, retain) Table2 *relationship;
@property (nullable, nonatomic, retain) NSSet<Table2 *> *relationship1;

@end

@interface Table1 (CoreDataGeneratedAccessors)

- (void)addRelationship1Object:(Table2 *)value;
- (void)removeRelationship1Object:(Table2 *)value;
- (void)addRelationship1:(NSSet<Table2 *> *)values;
- (void)removeRelationship1:(NSSet<Table2 *> *)values;

@end

NS_ASSUME_NONNULL_END
