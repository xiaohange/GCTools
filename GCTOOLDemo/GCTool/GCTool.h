//
//  GCTool.h
//  GCTool
//
//  Created by HanJunQiang on 16/6/21.
//  Copyright © 2016年 HaRi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <MessageUI/MessageUI.h>

@interface GCTool : NSObject
/**
 *  通过pic的url获得转变后的文件路径，和sdwebimage里面存的路径一致
 *
 *  @param picURL 下载图片的url地址
 *
 *  @return 下载之后的路径名
 */
+(NSString*)convertCCMD5Path:(NSString*)picURL;


+(NSString*)convertCCMD5:(NSString*)converStr;

/**
 *  通过unix time 转换成string格式的time
 *
 *  @param unixTime
 *  @param type type=1，转换的时间为2014-01-23 12:12
 *              type=2，转换的时间为2014-01-23 12:12:12
 *              type=3，转换的时间为2014-01-23
 *              其他，转换的时间为 01-23
 *
 *  @return 字符串时间
 */
+(NSString*)convertUnixTime:(NSInteger )unixTime timeType:(int)type;

/**
 *  计算时间到当前时间的跨度
 *
 *  @param timestamp 时间戳
 *
 *  @return 返回不同时间段的字符串
 */
+(NSString *)ttimeUptoNowFrom:(NSInteger)timestamp;
+(NSDate *)dateStartOfWeek:(NSDate *)date;//获取当前星期的第一天的时间戳
+(NSInteger)getDateInteger:(NSDate *)date;
+(NSString* )getDateString:(NSDate *)date;//获取时间戳
+(NSDate* )getStartOfMonth:(NSDate *)date;//获取当月第一天
+(BOOL)isOneDay:(NSInteger)t1 t2:(NSInteger)t2;

/**
 *  图片写入SDWEBIMAGE路径
 *
 *  @param url   图片url
 *  @param image data image
 */
+(void)saveImageByUrl:(NSString* )url image:(NSData* )image;

/**
 *  打电话
 *
 *  @param phoneNumber phoneNumber description
 */
+(void)callNumber:(NSString* )phoneNumber;

/**
 *  快捷首页时间   历史记录时间
 *
 *  @param unixTime
 */
+ (NSString *) quickTime:(NSInteger)unixTime isHistory:(BOOL)isHis showDetail:(BOOL)show;

/**
 *  根据颜色生成图片
 *
 *  @param UIColor
 */
+(UIImage *)getImageWithColor:(UIColor *)color;

/**
 *  将json格式字符串转换为字典
 *
 *  @param jsonStr <#jsonStr description#>
 *
 *  @return <#return value description#>
 */
+(id)coverJsonStrToDic:(NSString* )jsonStr;

+(NSString* )coverDicToStr:(id)dic;

/**
 *  UIAlertView - 简单提示框（无代理）
 *
 *  @param title          title
 *  @param msg            msg
 *  @param cancleBtnTitle cancleBtnTitle
 *  @param otherBtnTitle  otherBtnTitle
 */
+(void)alertView:(NSString* )title msg:(NSString* )msg cancleBtn:(NSString *)cancleBtnTitle otherBtnTitle:(NSString *)otherBtnTitle;

+(NSArray* )getArray:(id)array;

/**
 *  添加联系方式到通讯录
 *
 *  @param name        联系人姓名
 *  @param phoneNumber 联系人电话
 *
 *  @return 是否添加成功
 */
+ (BOOL)addContactName:(NSString *)name WithPhoneNumber:(NSString *)phoneNumber;

/**
 *  获取文本高度
 *
 *  @param text  要计算的字符串
 *  @param width 文本所占宽度
 *  @param font  字体大小
 *
 *  @return 文本高度
 */
+ (CGFloat)getText:(NSString *)text MinHeightWithBoundsWidth:(CGFloat)width fontSize:(CGFloat)fontSize;

/**
 *  获取子串以“,” " " "." 在父串中range位置
 *                   @"以.,空格"间隔
 *  @param string    子串
 *  @param allString 父串
 *
 *  @return return Range数组
 */
+ (NSMutableArray *)sepraterString:(NSString *)string andAllString:(NSString *)allString;

/**
 *  将数组转换成string，以逗号（，）隔开
 *
 *  @param array 数组
 *
 *  @return 以，隔开的字符串
 */
+(NSString*)stringWithArray:(NSMutableArray*)array;

/**
 *  验证邮箱的合法性
 *
 *  @param email 邮箱地址
 *
 *  @return 返回BOOL值
 */
+(BOOL)isValidateEmail:(NSString *)email;

/**
 *  验证手机号的合法性
 *
 *  @param mobile 手机号码
 *
 *  @return 返回BOOL值
 */
+(BOOL)isValidateMobile:(NSString *)mobile;

/**
 *  把图片压缩成宽度为w 高为h的
 *
 *  @param image 要压缩的图片
 *  @param h     压缩之后的高度
 *  @param w     压缩之后的宽度
 *
 *  @return 压缩之后的图片
 */

+(UIImage *)scaleImage:(UIImage *)image toHeight:(float)h toWidth:(float)w;

/**
 *  图标右上角数字-1
 */
+(void)minusIconBadgeNumber;

/**
 *  判断字符串是否包含特殊字符
 *
 *  @param myString myString
 *
 *  @return BOOL 值
 */
+(BOOL)isValidateStr:(NSString *)myString;

@end
