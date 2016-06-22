//
//  GCTool.m
//  GCTool
//
//  Created by HanJunQiang on 16/6/21.
//  Copyright © 2016年 HaRi. All rights reserved.
//

#import "GCTool.h"
#import "Reachability.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation GCTool

+(NSString*)convertUnixTime:(NSInteger )unixTime timeType:(int)type
{
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    switch (type) {
        case 0:
        {
            [YMD setDateFormat:@"HH:mm"];
        }
            break;
        case 1:
        {
            [YMD setDateFormat:@"yyyy-MM-dd HH:mm"];
        }
            break;
        case 2:
        {
            [YMD setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
        }
            break;
        case 3:
        {
            [YMD setDateFormat:@"yy/MM/dd"];
        }
            break;
        case 4:
        {
            [YMD setDateFormat:@"MM月dd日"];
        }
            break;
        case 5:
        {
            [YMD setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        }
            break;
        case 6:
        {
            [YMD setDateFormat:@"MM月dd日 HH:mm"];
        }
            break;
        case 7:
        {
            [YMD setDateFormat:@"yyyy年MM月dd日"];
        }
            break;
        case 8:
        {
            [YMD setDateFormat:@"yyyyMMddHHmmss"];
        }
            break;
        default:
            break;
    }
    NSDate* confromPostTime = [NSDate dateWithTimeIntervalSince1970:unixTime];
    
    return  [YMD stringFromDate:confromPostTime];
}

+ (NSString *) quickTime:(NSInteger)unixTime isHistory:(BOOL)isHis showDetail:(BOOL)show
{
    
    NSDate *nowDate = [NSDate date];
    NSInteger nowTimestamp = [nowDate timeIntervalSince1970];
    
    NSInteger currentStart = nowTimestamp-(nowTimestamp+8*3600)%(24*3600);
    
    NSInteger timeGap = currentStart-unixTime;
    
    NSString *reaultStr;
    
    if(timeGap <= 0) {
        reaultStr= show?[GCTool convertUnixTime:unixTime timeType:0]:@"今天";
    }else if (timeGap >0 && timeGap<=24*3600) {
        reaultStr = !isHis?[NSString stringWithFormat:@"昨天"]:show?[NSString stringWithFormat:@"昨天 %@",[GCTool convertUnixTime:unixTime timeType:0]]:[NSString stringWithFormat:@"昨天"];
    }else if (timeGap>24*3600 && timeGap<=2*24*3600) {
        reaultStr = !isHis?[NSString stringWithFormat:@"前天"]:show?[NSString stringWithFormat:@"前天 %@",[GCTool convertUnixTime:unixTime timeType:0]]:[NSString stringWithFormat:@"前天"];
    }else{
        reaultStr = !isHis?[GCTool convertUnixTime:unixTime timeType:3]:show?[self convertUnixTime:unixTime timeType:5]:[self convertUnixTime:unixTime timeType:7];
    }
    return reaultStr;
    
}

+(NSDate *)dateStartOfWeek:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] ;
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:date options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                        fromDate: beginningOfWeek];
    //gestript
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}

+(NSString* )getDateString:(NSDate *)date{
    NSString* dateString = [NSString stringWithFormat:@"%ld",[self getDateInteger:date]];
    return  dateString;
}

+(NSInteger)getDateInteger:(NSDate *)date
{
    return  (long)[date timeIntervalSince1970];
}

+(NSDate* )getStartOfMonth:(NSDate *)date
{
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    [YMD setDateFormat:@"yyyy.MM.dd"];
    [YMD setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString* a = [YMD stringFromDate:date];
    a = [a substringToIndex:[a length]-2];
    a = [a stringByAppendingString:@"01"];
    
    NSDate* beginningOfMonth = [YMD dateFromString:a];
    
    return beginningOfMonth;
}

+(BOOL)isOneDay:(NSInteger)t1 t2:(NSInteger)t2
{
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    [YMD setDateFormat:@"yyyy.MM.dd"];
    [YMD setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString* a = [YMD stringFromDate:[NSDate dateWithTimeIntervalSince1970:t1]];
    NSInteger newt = [self getDateInteger:[YMD dateFromString:a]];
    if (t2 > newt && t2 < newt + 86400) {
        return YES;
    }
    return NO;
}

+(NSString *)ttimeUptoNowFrom:(NSInteger)timestamp
{
    NSDate *nowDate = [NSDate date];
    NSInteger nowTimestamp = [nowDate timeIntervalSince1970];
    NSInteger second = 1;
    NSInteger minute = second * 60;
    NSInteger hour   = minute * 60;
    NSInteger day    = hour   * 24;
    NSInteger month  = day    * 30;
    NSInteger year   = month  * 12;
    
    NSInteger difference = nowTimestamp - timestamp;
    
    if (difference >= year) {
        return [GCTool convertUnixTime:timestamp timeType:1];
    } else if (difference >= day) {
        return [NSString stringWithFormat:@"%ld天前",difference/day];
    } else if (difference >= hour) {
        return [NSString stringWithFormat:@"%ld小时前",difference/hour];
    } else if (difference >= minute*5) {
        return [NSString stringWithFormat:@"%ld分钟前",difference/minute];
    } else {
        return @"刚刚";
    }
}

+ (BOOL)IsEnableWIFI
{
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

///Users/tianjing/Library/Application Support/iPhone Simulator/7.0.3/Applications/22B94F39-16BE-4E24-B24E-18AB7522F55F/Library/Caches/gongchang.com.SalesManager/fsCachedData
+(NSString*)convertCCMD5Path:(NSString*)picURL
{
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //下载路径
    NSString* downloadPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    const char *str = [picURL UTF8String];
    CC_MD5(str, (int)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    NSString* newDownloadPath = [downloadPath stringByAppendingPathComponent:filename];
    
    return newDownloadPath;
}

+(void)saveImageByUrl:(NSString* )url image:(NSData* )image
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [image writeToFile:[GCTool convertCCMD5Path:url] atomically:YES ];
    });
}

+(NSString*)convertCCMD5:(NSString*)converStr
{
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    const char *str = [converStr UTF8String];
    CC_MD5(str, (int)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;
    
    
}

+(void)callNumber:(NSString* )phoneNumber
{
    if (phoneNumber != nil) {
        [[UIApplication sharedApplication] openURL: [[NSURL alloc] initWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]]];
    }
}

+(id)coverJsonStrToDic:(id)jsonStr
{
    
    if ([jsonStr isKindOfClass:[NSArray class]] ||[jsonStr isKindOfClass:[NSDictionary class]]) {
        return jsonStr;
    }
    @try {
        if (jsonStr) {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:NSJSONReadingMutableLeaves
                                                              error:nil];
            if (jsonObject){
                return jsonObject;
            }else{
                // 解析错误
                return nil;
            }
        }else{
            return nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
}

+(NSString* )coverDicToStr:(id)dic
{
    if (dic) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        if (jsonData && [jsonData length]){
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }else{
            return @"";
        }
    }else{
        return @"";
    }
}

+(void)alertView:(NSString* )title msg:(NSString* )msg cancleBtn:(NSString *)cancleBtnTitle otherBtnTitle:(NSString *)otherBtnTitle
{
    [[[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:cancleBtnTitle otherButtonTitles:otherBtnTitle, nil]show];
}

+(UIImage *)getImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pressedColorImg;
}

+(NSArray* )getArray:(id)array
{
    if ([array isKindOfClass:[NSDictionary class]]) {
        return [array allObjects];
    }else if([array isKindOfClass:[NSArray class]]){
        return array;
    }else
        return nil;
}

+ (BOOL)addContactName:(NSString *)name WithPhoneNumber:(NSString *)phoneNumber
{
    
    ABAddressBookRef addressBook = nil;
    
    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    ABRecordRef record = ABPersonCreate();
    
    CFErrorRef error;
    
    ABRecordSetValue(record, kABPersonFirstNameProperty, (__bridge CFTypeRef)name, &error);
    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABPersonPhoneProperty);
    
    ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)phoneNumber, (__bridge CFTypeRef)@"", NULL);
    
    ABRecordSetValue(record, kABPersonPhoneProperty, multi, &error);
    if (multi) {
        CFRelease(multi);
    }
    ABAddressBookAddRecord(addressBook, record, &error);
    
    if (ABAddressBookHasUnsavedChanges(addressBook)){
        BOOL couldSaveAddressBook = NO;
        CFErrorRef couldSaveAddressBookError = NULL;
        couldSaveAddressBook = ABAddressBookSave(addressBook, &couldSaveAddressBookError);
        if (couldSaveAddressBook){
            NSLog(@"Successfully added the person to the group.");
            
            return YES;
        } else {
            NSLog(@"Failed to save the address book.");
            
            return NO;
        }
    }else{
        NSLog(@"Failed to save the address book.");
        
        return NO;
    }
}

+ (CGFloat)getText:(NSString *)text MinHeightWithBoundsWidth:(CGFloat)width fontSize:(CGFloat)fontSize
{
    CGFloat textHeight;
    
    @try {
        textHeight = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.height+1;
        
        return textHeight;
        
    }
    @catch (NSException *exception) {
        
        NSData *aa = [text dataUsingEncoding:NSUTF8StringEncoding];
        
        NSString *aaa = [[NSString alloc]initWithData:aa encoding:NSUTF8StringEncoding];
        
        textHeight = [aaa boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.height+1;
        
        return textHeight;
    }
}

+ (NSMutableArray *)sepraterString:(NSString *)string andAllString:(NSString *)allString
{
    NSMutableArray *rangeArray = [NSMutableArray new];
    
    if (!string) {
        
        return rangeArray;
    }
    @try {
        
        NSArray *charArray = [NSArray arrayWithObjects:@",",@" ",@".",nil];
        
        NSMutableString *text = [NSMutableString stringWithString:string];
        
        for (int i = 0; i<charArray.count; i++) {
            
            NSString *ctr = charArray[i];
            
            if ([text containsString:ctr]) {
                
                text = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:ctr withString:@","]];
                
            }
        }
        NSArray *sepArray = [text componentsSeparatedByString:@","];
        
        for (int i = 0; i< sepArray.count; i++) {
            
            NSString *sepStr = sepArray[i];
            
            NSRange range  = [allString rangeOfString:sepStr options:NSCaseInsensitiveSearch];
            
            if (range.location<=allString.length && range.length<=allString.length) {
                [rangeArray addObject:[NSValue valueWithRange:range]];
            }
        }
    }
    @catch (NSException *exception) {
    }
    return rangeArray;
}

+(NSString*)stringWithArray:(NSMutableArray*)array
{
    NSString *toString;
    if(array.count > 0)
    {
        toString = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
        for(int i = 1;i <array.count;i++)
        {
            toString = [NSString stringWithFormat:@"%@,%@",toString,[array objectAtIndex:i]];
        }
    }
    return toString;
}

//验证邮箱的合法性
+(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}
//验证手机号的合法性
+(BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
    
}

+(UIImage *)scaleImage:(UIImage *)image toHeight:(float)h toWidth:(float)w
{
    UIGraphicsBeginImageContext(CGSizeMake(h,w));
    [image drawInRect:CGRectMake(0, 0, h,w)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//图标右上角数字-1
+(void) minusIconBadgeNumber
{
    if ([[UIApplication sharedApplication] applicationIconBadgeNumber] >0) [UIApplication sharedApplication].applicationIconBadgeNumber
    -=1;
}

+(BOOL)isValidateStr:(NSString *)myString
{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSRange userNameRange = [myString rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        //NSLog(@"包含特殊字符");
        return FALSE;
    }else{
        return TRUE;
    }
    
}


@end
