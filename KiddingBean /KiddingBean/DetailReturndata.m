#import "DetailReturndata.h"

@implementation DetailReturndata
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
	return YES;
}

+ (JSONKeyMapper *)keyMapper {
	return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"theID",@"ID":@"theID",@"class":@"theClass",@"Class":@"theClass",@"description":@"theDescription"}];
}
@end
