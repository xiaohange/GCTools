//
//  ViewController.m
//  GCTOOLDemo
//
//  Created by HanJunQiang on 16/6/22.
//  Copyright © 2016年 HaRi. All rights reserved.
//

#import "ViewController.h"
#import "GCTools.h"
#import "GCKeyChain.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // test 记得用真机测试 GCKeyChain.h
    if (![GCKeyChain keyChainLoad]) {
        [GCKeyChain keyChainSave:[[NSUUID UUID]UUIDString]];
        NSLog(@"keyChain save success");
    }else {
        NSLog(@"Load_UUID: %@",[GCKeyChain keyChainLoad]);
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
