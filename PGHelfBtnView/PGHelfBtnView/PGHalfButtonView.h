//
//  QLHJHalfButtonView.h
//  QeelinGold-iOS
//
//  Created by 张培根 on 2017/5/11.
//  Copyright © 2017年 ChenWei. All rights reserved.
//

#define PGWeakSelf __weak typeof(self) weakSelf = self;
#define PGHalfStateChange @"PGHalfStateChange"

#import <UIKit/UIKit.h>
#import "UIButton+Extension.h"

typedef NS_ENUM(NSUInteger, tickState) {
    tickSelected,
    tickUnselected,
};

@interface PGHalfButtonView : UIView


/**
 默认初始化方法

 @param strA 前半部分字符
 @param labelColor 前半部分颜色
 @param strB 后半部分字符
 @param buttonColor 后半部分颜色
 @param font 字体
 @param actionBlock 点击事件
 @return 初始化对象
 */
-(instancetype)initWithText:(NSString *)strA color:(UIColor *)labelColor Text:(NSString *)strB color:(UIColor *)buttonColor font:(UIFont *)font action:(ActionBlock)actionBlock;
-(instancetype)initWithText:(NSString *)strA color:(UIColor *)textColor Text:(NSString *)strB color:(UIColor *)btnColor action:(ActionBlock)actionBlock;
-(instancetype)initWithProtocolText:(NSString *)strA Text:(NSString *)strB action:(ActionBlock)actionBlock;


/**
 xib的初始化方法
 
 @param strA 前半部分字符
 @param labelColor 前半部分颜色
 @param strB 后半部分字符
 @param buttonColor 后半部分颜色
 @param font 字体
 @param actionBlock 点击事件
 */
-(void)setText:(NSString *)strA color:(UIColor *)labelColor Text:(NSString *)strB color:(UIColor *)buttonColor font:(UIFont *)font action:(ActionBlock)actionBlock;
-(void)setText:(NSString *)strA color:(UIColor *)labelColor Text:(NSString *)strB color:(UIColor *)buttonColor action:(ActionBlock)actionBlock;


/**
 显示对号框，设置对号框的状态，获取对号框的状态
 */
@property (assign,nonatomic) tickState tickState;

@end
