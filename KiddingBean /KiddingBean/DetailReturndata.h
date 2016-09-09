#import "JSONModel.h"
#import "LPModelJokeComic.h"
//#import "LPModelJokeOtherworks.h"
#import "LPModelJokeChapter_List.h"

@interface DetailReturndata : JSONModel
@property (nonatomic, strong) LPModelJokeComic <Optional> * comic;
//@property (nonatomic, strong) NSArray <LPModelJokeOtherworks, Optional> * otherWorks;
@property (nonatomic, strong) NSArray <LPModelJokeChapter_List, Optional> * chapter_list;
@end