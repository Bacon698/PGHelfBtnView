//
//  QLHJHelfButtonView.h
//  QeelinGold-iOS
//
//  Created by 张培根 on 2017/5/11.
//  Copyright © 2017年 ChenWei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, tickState) {
    tickSelected,
    tickUnselected,
};

@interface QLHJHelfButtonView : UIView

-(instancetype)initWithText:(NSString *)strA color:(UIColor *)textColor Text:(NSString *)strB color:(UIColor *)btnColor action:(ActionBlock)actionBlock;

-(instancetype)initWithProtocolText:(NSString *)strA Text:(NSString *)strB action:(ActionBlock)actionBlock;

-(void)showTick;

-(tickState)tickState;

@end
