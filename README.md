#GCTool
[![CircleCI](https://img.shields.io/circleci/project/github/RedSparr0w/node-csgo-parser.svg)](https://github.com/XiaoHanGe/GCTools)
[![Version](https://img.shields.io/cocoapods/v/GCTools.svg?style=flat)](http://cocoapods.org/pods/GCTools)
[![Coveralls branch](https://img.shields.io/coveralls/jekyll/jekyll/master.svg)](https://github.com/XiaoHanGe/GCTools)
[![Packagist](https://img.shields.io/packagist/l/doctrine/orm.svg)](https://github.com/XiaoHanGe/GCTools)
[![Platform](https://img.shields.io/badge/platform-ios-brightgreen.svg)](http://cocoapods.org/pods/GCTools)
[![CocoaPods](https://img.shields.io/cocoapods/dm/AFNetworking.svg)](http://cocoapods.org/pods/GCTools)

##简介
####iOS 中常用的工具类：
######1.通过pic的url获得转变后的文件路径，和sdwebimage里面存的路径一致；
######2.通过unix time 转换成string格式的time；
######3.计算时间到当前时间的跨度；
######4.检测是否WIFI; 
######5.图片写入SDWEBIMAGE路径; 
######6.打电话; 
######7.快捷首页时间   历史记录时间;
######8.根据颜色生成图片; 
######9.将json格式字符串转换为字典; 
######10.UIAlertView - 简单提示框（无代理）; 
######11.添加联系方式到通讯录; 
######12.获取文本高度; 
######13.获取子串以“,” " " "." 在父串中range位置; 
######14.将数组转换成string，以逗号（，）隔开; 
######15.验证邮箱的合法性; 
######16.验证手机号的合法性; 
######17.把图片压缩成宽度为w 高为h的; 
######18.图标右上角数字-1; 
######19.判断字符串是否包含特殊字符;  
####GCProgressView：  
- 一个动态进度条

####文档：
- `_progressLine1.trackTintColor = [UIColor colorWithRed:0 green:120/255.f blue:1 alpha:1];`
- `//设置背景颜色
    _progressLine1.backgroundColor = [UIColor colorWithRed:216/255.f green:216/255.f blue:216/255.f alpha:1];`
- `_progressLine1.cornerRadius = 3;  //设置圆角`
- `_progressLine1.progressValue = 30;    //设置当前值_progressLine1.progressMaxValue = 100; //设置最大值`
- `_progressLine1.progressValue = 30;    //设置当前值`

####效果如下：
[![CocoaPods](https://github.com/XiaoHanGe/GCTools/blob/master/1.gif?raw=true)](http://cocoapods.org/pods/JQSafeKit)

###GCKeyChain
- 一个存储UUID工具类

- `+ (void)keyChainSave:(NSString *)service;//
  keyChain _用来存储UUID，即使删除APP也会保留很不错的🔑储存`
- `+ (NSString *)keyChainLoad;`
- `+ (void)keyChainDelete;`

##How To Use
####请看Demo

##Author

- [小韩哥-CSDN](http://blog.csdn.net/qq_31810357) 

###iOS开发者交流群：446310206

