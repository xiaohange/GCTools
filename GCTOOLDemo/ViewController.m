//
//  ViewController.m
//  GCTOOLDemo
//
//  Created by HanJunQiang on 16/6/22.
//  Copyright © 2016年 HaRi. All rights reserved.
//

#import "ViewController.h"
#import "GCTool/GCTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 不一一测试
    // wifi
    BOOL isWifi = [GCTool IsEnableWIFI];
    isWifi ? NSLog(@"wifi"):NSLog(@"noWifi");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
