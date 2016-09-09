#import "JSONModel.h"

@protocol LPModelJokeList <NSObject>
@end

@interface LPModelJokeList : JSONModel
@property (nonatomic, copy) NSString <Optional> * title;
@property (nonatomic, copy) NSString <Optional> * summary;
@property (nonatomic, copy) NSString <Optional> * channel_desc;
@property (nonatomic, copy) NSString <Optional> * image_spec;
@property (nonatomic, copy) NSString <Optional> * is_new;
@property (nonatomic, copy) NSString <Optional> * publication_date;
@property (nonatomic, copy) NSString <Optional> * article_url;
@property (nonatomic, copy) NSString <Optional> * is_direct;
@property (nonatomic, copy) NSString <Optional> * image_url_small;
@property (nonatomic, copy) NSString <Optional> * image_url_big;
@property (nonatomic, copy) NSString <Optional> * article_id;
@property (nonatomic, copy) NSString <Optional> * image_with_btn;
@property (nonatomic, copy) NSString <Optional> * score;
@property (nonatomic, copy) NSString <Optional> * insert_date;
@property (nonatomic, copy) NSString <Optional> * is_top;
@property (nonatomic, copy) NSString <Optional> * targetid;
@property (nonatomic, copy) NSString <Optional> * channel_id;
@property (nonatomic, copy) NSString <Optional> * is_act;
@property (nonatomic, copy) NSString <Optional> * is_hot;
@property (nonatomic, copy) NSString <Optional> * is_subject;
@property (nonatomic, copy) NSString <Optional> * intent;
@end