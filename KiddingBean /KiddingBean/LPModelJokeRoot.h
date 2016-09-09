#import "JSONModel.h"
#import "LPModelJokeList.h"

@interface LPModelJokeRoot : JSONModel
@property (nonatomic, strong) NSArray <LPModelJokeList, Optional> * list;
@property (nonatomic, copy) NSString <Optional> * next;
@property (nonatomic, copy) NSString <Optional> * this_page_num;
@property (nonatomic, copy) NSString <Optional> * previous;
@end