//
//  GCKeyChain.m
//  GCKeyChain.h
//
//  Created by HaRi on 16/11/23.
//  Copyright © 2016年 HanJunQiang. All rights reserved.
//  博主：http://blog.csdn.net/qq_31810357
//

#import "GCKeyChain.h"

#define KBUNDLE_ID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
static NSString * const kPDDictionaryKey = @".dictionaryKey";

static NSString * const kGCKeyChainKey = @".keychainKey";

@implementation GCKeyChain

+ (void)keyChainSave:(NSString *)service {
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:service forKey:[NSString stringWithFormat:@"%@%@",KBUNDLE_ID,kPDDictionaryKey]];
    [self save:[NSString stringWithFormat:@"%@%@",KBUNDLE_ID,kGCKeyChainKey] data:tempDic];
}

+ (NSString *)keyChainLoad{
    NSMutableDictionary *tempDic = (NSMutableDictionary *)[self load:[NSString stringWithFormat:@"%@%@",KBUNDLE_ID,kGCKeyChainKey]];
    return [tempDic objectForKey:[NSString stringWithFormat:@"%@%@",KBUNDLE_ID,kPDDictionaryKey]];
}

+ (void)keyChainDelete{
    [self delete:[NSString stringWithFormat:@"%@%@",KBUNDLE_ID,kGCKeyChainKey]];
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

@end
