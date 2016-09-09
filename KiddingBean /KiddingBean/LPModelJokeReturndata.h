#import "JSONModel.h"
//#import "LPModelJokeTags.h"

//@protocol LPModelJokeReturndata <NSObject>
//@end

@interface LPModelJokeReturndata : JSONModel
@property (nonatomic, copy) NSString <Optional> * theDescription;
@property (nonatomic, copy) NSString <Optional> * comic_id;
@property (nonatomic, copy) NSString <Optional> * chapter_num;
@property (nonatomic, copy) NSString <Optional> * last_update_chapter_id;
@property (nonatomic, copy) NSString <Optional> * is_dujia;
@property (nonatomic, copy) NSString <Optional> * extraValue;
@property (nonatomic, copy) NSString <Optional> * is_free;
@property (nonatomic, copy) NSString <Optional> * click_total;
//@property (nonatomic, strong) NSArray <LPModelJokeTags, Optional> * tags;
@property (nonatomic, copy) NSString <Optional> * accredit;
@property (nonatomic, copy) NSString <Optional> * user_id;
@property (nonatomic, copy) NSString <Optional> * theme_ids;
@property (nonatomic, copy) NSString <Optional> * cover;
@property (nonatomic, copy) NSString <Optional> * series_status;
@property (nonatomic, copy) NSString <Optional> * last_update_chapter_name;
@property (nonatomic, copy) NSString <Optional> * nickname;
@property (nonatomic, copy) NSString <Optional> * is_vip;
@property (nonatomic, copy) NSString <Optional> * name;
@property (nonatomic, copy) NSString <Optional> * last_update_time;
@end