//
//  CLCountdownView.m
//  CLCountdownView
//
//  Created by 李辉 on 15/12/17.
//  Copyright © 2015年 李辉. All rights reserved.
//  https://github.com/changelee82/CLCountdownView
//

#import "CLCountdownView.h"

@interface CLCountdownView()

@property (nonatomic, assign) NSInteger currentNumber;
@property (nonatomic, strong) NSTimer *timer;     // 计时器

@end



@implementation CLCountdownView

#pragma mark - 初始化

/** 初始化方法，用于从代码中创建的类实例 */
- (id)init
{
    self = [super init];
    if (self = [super init])
    {
        [self defaultInit];
    }
    return self;
}

/** 初始化方法，用于从代码中创建的类实例 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

/** 初始化方法，用于从xib文件中载入的类实例 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

/** 默认的初始化方法 */
- (void)defaultInit
{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    _currentNumber = 3;
    _startNumber = 3;
    _finishText = @"GO";
    _numberFont = [UIFont fontWithName:@"DIN Condensed" size:self.frame.size.height];
    _finishFont = [UIFont boldSystemFontOfSize:self.frame.size.height];
    _numberColor = [UIColor whiteColor];
    _finishColor = [UIColor whiteColor];
    
}


- (void)awakeFromNib
{
    // 布局倒计时Label
    [self layoutAllLabel];
}

/**
 *  布局全部Label
 */
- (void)layoutAllLabel
{
    // 删除所有倒计时Label
    for(UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    
    // 重新布局倒计时Label
    CGRect frame = self.frame;
    for (NSInteger i = _startNumber; i >= 0; --i)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (_startNumber-i)*frame.size.height, frame.size.width, frame.size.height)];
        
        label.textAlignment = NSTextAlignmentCenter;
        if (i > 0)
        {
            label.text = [NSString stringWithFormat:@"%ld", (long)i];
            label.font = _numberFont;
            label.textColor = _numberColor;
        }
        else
        {
            label.text = _finishText;
            label.font = _finishFont;
            label.textColor = _finishColor;
        }
        
        [self addSubview:label];
    }
}


#pragma mark - 属性

- (void)setStartNumber:(NSInteger)startNumber
{
    _startNumber = startNumber;
       _currentNumber = _startNumber;
    
    // 布局倒计时Label
    [self layoutAllLabel];
}

- (void)setFinishText:(NSString *)finishText
{
    _finishText = finishText;
    
    // 布局倒计时Label
    [self layoutAllLabel];
}

- (void)setNumberFont:(UIFont *)numberFont
{
    _numberFont = numberFont;
    
    // 布局倒计时Label
    [self layoutAllLabel];
}

- (void)setFinishFont:(UIFont *)finishFont
{
    _finishFont = finishFont;
    
    // 布局倒计时Label
    [self layoutAllLabel];
}

- (void)setNumberColor:(UIColor *)numberColor
{
    _numberColor = numberColor;
    
    // 布局倒计时Label
    [self layoutAllLabel];
}

- (void)setFinishColor:(UIColor *)finishColor
{
    _finishColor = finishColor;
    
    // 布局倒计时Label
    [self layoutAllLabel];
}

#pragma mark - 方法

- (void)startCountdown
{
    self.startNumber = _startNumber;
    self.bounds = CGRectMake(0, (_startNumber-_currentNumber)*self.frame.size.height,
                             self.frame.size.width, self.frame.size.height);
    
    // 创建一个定时器，并直接加入到当前的消息循环中
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(triggerTimerNotification)
                                                userInfo:nil
                                                 repeats:YES];
    }
    
}

-(void) triggerTimerNotification
{
    // 动画
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         // 动画位移视图
                         self.bounds = CGRectMake(0, (_startNumber-_currentNumber)*self.frame.size.height,
                                                  self.frame.size.width, self.frame.size.height);
                     }
                     completion:nil];
    
    // 调用Block
    if (_currentNumber <= 0)
    {
        if (_countDownFinishBlock)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                _countDownFinishBlock ();
            });
        }
        
        [_timer invalidate];
        _timer = nil;   // 释放计时器
        return;
    }
    else
    {
        if (_numberChangeBlock)
        {
            _numberChangeBlock(_currentNumber);
        }
    }
    
    --_currentNumber;
}

@end