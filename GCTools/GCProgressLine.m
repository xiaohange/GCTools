//
//  GCProgressLine.m
//
//  Created by HanJunQiang on 16/4/25. V：1.0.0
//  Copyright © 2016年 HaRi. All rights reserved.
//  博主：http://blog.csdn.net/qq_31810357
//

#import "GCProgressLine.h"

@interface GCProgressLine ()
/**
 *  进度条 progressView
 */
@property (nonatomic, strong) UIView *progressView;

/**
 *  progressView Rect
 */
@property (nonatomic) CGRect rect_progressView;

/**
 *  限制高度大小
 *
 *  @param rect self.height
 */
- (void)_setHeightRestrictionOfFrame:(CGFloat)height;

@end

@implementation GCProgressLine


- (UIView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.progressView];
    }
    return _progressView;
}

#pragma mark -  initWithFrame

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setHeightRestrictionOfFrame:frame.size.height];
    }
    return self;
}

#pragma mark - Privite Method
- (void)_setHeightRestrictionOfFrame:(CGFloat)height
{
    _progressHeight = height;
    self.rect_progressView = CGRectZero;
    _rect_progressView.size.height = _progressHeight;
    self.progressView.frame = self.rect_progressView;
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    if (cornerRadius) {
        self.layer.cornerRadius = self.progressView.layer.cornerRadius =  cornerRadius;
    }
}

#pragma mark - Setter

- (void)setProgressHeight:(CGFloat)progressHeight
{
    [self _setHeightRestrictionOfFrame:progressHeight];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor = progressTintColor;
    
    self.backgroundColor = _progressTintColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    _trackTintColor = trackTintColor;
    
    self.progressView.backgroundColor = _trackTintColor;
}

- (void)setProgressValue:(CGFloat)progressValue
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (progressValue > _progressMaxValue) {
            _progressValue = _progressMaxValue;
        }else{
            _progressValue  = progressValue;
        }
        _rect_progressView.size.width = self.bounds.size.width*_progressValue/_progressMaxValue;
        _rect_progressView.size.height = self.bounds.size.height;
        NSTimeInterval durationValue = (_progressValue/2.0) / _progressMaxValue + .5;
        if (!self.progressView.frame.size.height) self.progressView.frame = CGRectMake(0, 0, 0, self.frame.size.height);
        [UIView animateWithDuration:durationValue animations:^{
            self.progressView.frame = _rect_progressView;
        }];
    });
}

@end
