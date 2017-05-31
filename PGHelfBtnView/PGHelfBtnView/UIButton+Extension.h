//
//  UIButton+Extension.h
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/5/10.
//  Copyright © 2017年 ChenWei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,UIButtonPosition) {
    UIButtonPositionLeft = 0,
    UIButtonPositionCenter,
    UIButtonPositionRight,
};


typedef void (^ActionBlock)(UIButton *button);
typedef void (^ImmediateActionBlock)(UIButton *button);
@interface UIButton (Extension)


/**
 创建button封装的bolck事件
 */
+ (UIButton *)btnWithActionBlock:(ActionBlock)actionBlock;


/**
 创建一个立即响应的button
 */
+ (UIButton *)immediateBtnWithActionBlock:(ImmediateActionBlock)ImmediateActionBlock;

/**
 立即响应
 */
+ (UIButton *)immediatBtnWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage highLightedImage:(UIImage *)highLightedImage actionBlock:(ImmediateActionBlock)immediateActionBlock;

/**
 创建一个普通的button，只有文字，无其它的任何样式

 @param titleStr 文字
 @param TextFont 文字大小
 */
+ (UIButton *)createNormalBtnWithTitle:(NSString *)titleStr withFont:(UIFont *)TextFont withColor:(UIColor *)textColot actionBlock:(ActionBlock)actionBlock;


@end
