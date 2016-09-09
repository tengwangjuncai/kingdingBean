#import "LPModelJokeImage_Size.h"

@implementation LPModelJokeImage_Size
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
	return YES;
}

+ (JSONKeyMapper *)keyMapper {
	return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"theID",@"ID":@"theID",@"class":@"theClass",@"Class":@"theClass",@"description":@"theDescription"}];
}
@end
