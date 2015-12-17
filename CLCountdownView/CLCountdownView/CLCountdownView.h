//
//  CLCountdownView.h
//  CLCountdownView
//
//  Created by 李辉 on 15/12/17.
//  Copyright © 2015年 李辉. All rights reserved.
//  https://github.com/changelee82/CLCountdownView
//

#import <UIKit/UIKit.h>

/**
 *  倒计时视图
 */
@interface CLCountdownView : UIView


/** 倒计时起始数字，默认为3 */
@property (nonatomic, assign) NSInteger startNumber;

/** 倒计时结束时，用于代替0的字符串，默认为0 */
@property (nonatomic, copy) NSString *finishText;


/** 倒计时数字字体，默认字体“DIN Condensed”，默认高度为视图高度 */
@property (nonatomic, strong) UIFont *numberFont;

/** 结束字符串字体，默认字体“boldSystemFont”，默认高度为视图高度 */
@property (nonatomic, strong) UIFont *finishFont;


/** 数字字体颜色，默认白色 */
@property (nonatomic, strong) UIColor *numberColor;

/** 结束字符串字体颜色，默认白色 */
@property (nonatomic, strong) UIColor *finishColor;


/** 倒计时数字变动后调用的Block */
@property (copy) void (^numberChangeBlock) (NSInteger number);

/** 倒计时结束后调用的Block */
@property (copy) void (^countDownFinishBlock) ();


/** 开始计时 */
- (void)startCountdown;


@end
