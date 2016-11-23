//
//  GCProgressLine.h
//
//  Created by HanJunQiang on 16/4/25.
//  Copyright © 2016年 HaRi. All rights reserved.
//  说明：进度条progressValue 最大为 GCProgressLine的宽度  V：1.0.0
//  博主：http://blog.csdn.net/qq_31810357
//

#import <UIKit/UIKit.h>

@interface GCProgressLine : UIView


/**
 *  进度条高度
 */
@property (nonatomic, assign) CGFloat progressHeight;

/**
 *  进度最大值  maxValue
 */
@property (nonatomic, assign) CGFloat progressMaxValue;


/**
 *  进度值  value
 */
@property (nonatomic, assign) CGFloat progressValue;

/**
 *   动态进度条颜色  Dynamic progress
 */
@property (nonatomic, strong) UIColor *trackTintColor;

/**
 *  静态背景颜色    static progress 默认可以storyboard定义
 */
@property (nonatomic, strong) UIColor *progressTintColor;

@property (nonatomic, assign) CGFloat cornerRadius;


@end
