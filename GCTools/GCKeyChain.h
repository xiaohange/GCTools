//
//  GCKeyChain.h
//  GCKeyChain.h
//
//  Created by HaRi on 16/11/23.
//  Copyright © 2016年 HanJunQiang. All rights reserved.
//  博主：http://blog.csdn.net/qq_31810357
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface GCKeyChain : NSObject

/**
  keyChain _用来存储UUID，即使删除APP也会保留

 @param service 很不错的🔑储存
 */
+ (void)keyChainSave:(NSString *)service;

+ (NSString *)keyChainLoad;

+ (void)keyChainDelete;

@end
