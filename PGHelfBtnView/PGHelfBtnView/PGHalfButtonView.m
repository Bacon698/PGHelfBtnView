//
//  QLHJHalfButtonView.m
//  QeelinGold-iOS
//
//  Created by 张培根 on 2017/5/11.
//  Copyright © 2017年 ChenWei. All rights reserved.
//

#define tickInterval 5
#define defaultFontSize 14

#import "PGHalfButtonView.h"
#import "Masonry.h"


@interface PGHalfButtonView (){
    UIImage *_tickSelectedImage;
    UIImage *_tickUnselectedImage;
    float _tickWidth;
    UIFont *_defaultFont;
}

@property (copy) ActionBlock myBlock;

@property (copy,nonatomic) NSString *labelStr;
@property (copy,nonatomic) NSString *buttonStr;
@property (strong,nonatomic) UIColor *labelColor;
@property (strong,nonatomic) UIColor *buttonColor;

@property (strong,nonatomic) UILabel *label;
@property (strong,nonatomic) UIButton *button;
@property (strong,nonatomic) UIButton *tickButton;

@end

@implementation PGHalfButtonView


/**
 默认参数
 */
-(void)defaultParameter{
    _tickSelectedImage = [UIImage imageNamed:@"agreeBtn_selected"];
    _tickUnselectedImage = [UIImage imageNamed:@"agreeBtn_notSelect"];
    _defaultFont = [UIFont systemFontOfSize:defaultFontSize];
    _tickWidth = _tickSelectedImage.size.width;
}

/**
 内部布局
 */
-(void)setup{
    
    PGWeakSelf
    self.tickButton = [UIButton immediatBtnWithNormalImage:_tickUnselectedImage selectedImage:_tickSelectedImage highLightedImage:nil actionBlock:^(UIButton *button) {
        weakSelf.tickButton.selected = !weakSelf.tickButton.selected;
        [weakSelf tickStateChange];
    }];
    [self addSubview:self.tickButton];
    self.tickButton.selected = YES;
    self.tickButton.adjustsImageWhenHighlighted = NO;
    
    self.label = [UILabel new];
    self.label.font = _defaultFont;
    self.label.text = self.labelStr;
    self.label.textColor = self.labelColor;
    [self addSubview:self.label];
    
    self.button = [UIButton createNormalBtnWithTitle:self.buttonStr withFont:_defaultFont withColor:self.buttonColor actionBlock:self.myBlock];
    [self addSubview:self.button];
    
    [self.tickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(_tickWidth);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(_tickWidth + tickInterval);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.label.mas_right);
        make.right.top.bottom.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    
    [self hidenTick];
}

#pragma mark --------代码生成初始化方法--------
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultParameter];
    }
    return self;
}

-(instancetype)initWithText:(NSString *)strA color:(UIColor *)labelColor Text:(NSString *)strB color:(UIColor *)buttonColor font:(UIFont *)font action:(ActionBlock)actionBlock{
    self = [self init];
    if (self) {
        self.myBlock = actionBlock;
        self.labelStr = strA;
        self.buttonStr = strB;
        self.labelColor  = labelColor;
        self.buttonColor  = buttonColor;
        if(font){
            _defaultFont = font;
        }
        [self setup];
    }
    return self;
}

-(instancetype)initWithText:(NSString *)strA color:(UIColor *)labelColor Text:(NSString *)strB color:(UIColor *)buttonColor action:(ActionBlock)actionBlock{
    self = [self init];
    if (self) {
        self.myBlock = actionBlock;
        self.labelStr = strA;
        self.buttonStr = strB;
        self.labelColor  = labelColor;
        self.buttonColor  = buttonColor;
        [self setup];
    }
    return self;
}

-(instancetype)initWithProtocolText:(NSString *)strA Text:(NSString *)strB action:(ActionBlock)actionBlock{
    self = [self init];
    if (self) {
        self.myBlock = actionBlock;
        self.labelStr = strA;
        self.buttonStr = strB;
        self.labelColor  = [UIColor colorWithRed:56/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        self.buttonColor  = [UIColor colorWithRed:55/255.0 green:175/255.0 blue:244/255.0 alpha:1];
        [self setup];
    }
    return self;
}

#pragma mark --------xib设置方法--------
-(void)awakeFromNib{
    [super awakeFromNib];
    [self defaultParameter];
}

-(void)setText:(NSString *)strA color:(UIColor *)labelColor Text:(NSString *)strB color:(UIColor *)buttonColor action:(ActionBlock)actionBlock{
    self.myBlock = actionBlock;
    self.labelStr = strA;
    self.buttonStr = strB;
    self.labelColor  = labelColor;
    self.buttonColor  = buttonColor;
    [self setup];

}

-(void)setText:(NSString *)strA color:(UIColor *)labelColor Text:(NSString *)strB color:(UIColor *)buttonColor font:(UIFont *)font action:(ActionBlock)actionBlock{
    self.myBlock = actionBlock;
    self.labelStr = strA;
    self.buttonStr = strB;
    self.labelColor  = labelColor;
    self.buttonColor  = buttonColor;
    if(font){
        _defaultFont = font;
    }
    [self setup];
}

#pragma mark --------选中框相关方法--------
-(tickState)tickState{
    if (self.tickButton.selected == YES) {
        return tickSelected;
    }else{
        return tickUnselected;
    }
}

-(void)setTickState:(tickState)tickState{
    [self showTick];
    if (tickState == tickSelected) {
        
    }else{
        self.tickButton.selected = NO;
    }
}

-(void)tickStateChange{
    [[NSNotificationCenter defaultCenter] postNotificationName:PGHalfStateChange object:nil];
}

-(void)showTick{
    self.tickButton.hidden = NO;
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(_tickWidth + tickInterval);
    }];
}

-(void)hidenTick{
    self.tickButton.hidden = YES;
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
    }];
}



@end
