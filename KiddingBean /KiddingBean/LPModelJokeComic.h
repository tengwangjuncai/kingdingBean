#import "JSONModel.h"
#import "LPModelJokeAuthor.h"
#import "LPModelJokeThread.h"

@interface LPModelJokeComic : JSONModel
@property (nonatomic, copy) NSString <Optional> * series_status;
@property (nonatomic, copy) NSString <Optional> * theDescription;
@property (nonatomic, strong) LPModelJokeAuthor <Optional> * author;
@property (nonatomic, copy) NSString <Optional> * click_total;
@property (nonatomic, copy) NSString <Optional> * ori;
@property (nonatomic, copy) NSString <Optional> * expired_time;
@property (nonatomic, copy) NSString <Optional> * total_ticket;
@property (nonatomic, copy) NSString <Optional> * cover;
@property (nonatomic, copy) NSString <Optional> * month_ticket;
@property (nonatomic, copy) NSString <Optional> * name;
@property (nonatomic, copy) NSString <Optional> * click_month;
@property (nonatomic, copy) NSString <Optional> * type;
@property (nonatomic, copy) NSString <Optional> * theme_ids;
@property (nonatomic, copy) NSString <Optional> * accredit;
@property (nonatomic, copy) NSString <Optional> * comic_id;
@property (nonatomic, copy) NSString <Optional> * server_time;
@property (nonatomic, copy) NSString <Optional> * image_all;
@property (nonatomic, copy) NSString <Optional> * share_total;
@property (nonatomic, copy) NSString <Optional> * monthly_click;
@property (nonatomic, copy) NSString <Optional> * is_dub;
@property (nonatomic, copy) NSString <Optional> * comment_total;
@property (nonatomic, copy) NSString <Optional> * read_order;
@property (nonatomic, strong) LPModelJokeThread <Optional> * thread;
@property (nonatomic, copy) NSString <Optional> * total_tucao;
@property (nonatomic, copy) NSString <Optional> * last_update_time;
@property (nonatomic, copy) NSString <Optional> * monthly_ticket;
@property (nonatomic, copy) NSString <Optional> * cate_id;
@end