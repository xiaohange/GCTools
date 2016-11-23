//
//  progressLineDemo.m
//  progressLine
//
//  Created by HanJunqiang on 16/6/15.
//  Copyright © 2016年 HaRi. All rights reserved.
//  博主：http://blog.csdn.net/qq_31810357
//

#import "progressLineDemo.h"
#import "GCProgressLine.h"

@interface progressLineDemo(){
    
}

@property (weak, nonatomic) IBOutlet GCProgressLine *progressLine1;
@property (weak, nonatomic) IBOutlet GCProgressLine *progressLine2;
@property (weak, nonatomic) IBOutlet GCProgressLine *progressLine3;

@end

@implementation progressLineDemo

-(void)viewDidLoad{
    
    _progressLine1.trackTintColor = [UIColor colorWithRed:0 green:120/255.f blue:1 alpha:1];
    //设置背景颜色
    _progressLine1.backgroundColor = [UIColor colorWithRed:216/255.f green:216/255.f blue:216/255.f alpha:1];
    _progressLine1.cornerRadius = 3;  //设置圆角
    _progressLine1.progressMaxValue = 100; //设置最大值
    _progressLine1.progressValue = 30;    //设置当前值
    
    
    
    
    _progressLine2.trackTintColor = [UIColor blackColor];
    _progressLine2.backgroundColor = [UIColor grayColor];
    _progressLine2.cornerRadius = 5;  //设置圆角
    _progressLine2.progressMaxValue = 7; //设置最大值
    _progressLine2.progressValue = 57;    //设置当前值
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _progressLine2.progressValue = 2;
    });
    
    
    
    
    _progressLine3.trackTintColor = [UIColor colorWithRed:0 green:120/255.f blue:1 alpha:1];
    //设置背景颜色
    _progressLine3.backgroundColor = [UIColor colorWithRed:216/255.f green:216/255.f blue:216/255.f alpha:1];
    _progressLine3.cornerRadius = 15;  //设置圆角
    _progressLine3.progressMaxValue = 100; //设置最大值
    _progressLine3.progressValue = 30;    //设置当前值
    
    
}


@end
