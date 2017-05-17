//
//  QLHJHelfButtonView.m
//  QeelinGold-iOS
//
//  Created by 张培根 on 2017/5/11.
//  Copyright © 2017年 ChenWei. All rights reserved.
//
#define tickInterval 5

#import "QLHJHelfButtonView.h"

@interface QLHJHelfButtonView (){
    UIImage *_tickSelectedImage;
    UIImage *_tickUnselectedImage;
    float _tickWidth;
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

@implementation QLHJHelfButtonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tickSelectedImage = [UIImage imageNamed:@"agreeBtn_selected"];
        _tickUnselectedImage = [UIImage imageNamed:@"agreeBtn_notSelect"];
        _tickWidth = _tickSelectedImage.size.width;
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
        self.labelColor  = [AppSkin color383232];
        self.buttonColor  = [AppSkin colorBlue];
        [self setup];
    }
    return self;
}

-(tickState)tickState{
    if (self.tickButton.selected == YES) {
        return tickSelected;
    }else{
        return tickUnselected;
    }
}

-(void)tickStateChange{
    [[NSNotificationCenter defaultCenter] postNotificationName:iconTextFieldTextChange object:nil];
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

-(void)setup{
    
    QLWeakSelf
    self.tickButton = [UIButton immediatBtnWithNormalImage:_tickUnselectedImage selectedImage:_tickSelectedImage highLightedImage:nil actionBlock:^(UIButton *button) {
        weakSelf.tickButton.selected = !weakSelf.tickButton.selected;
        [weakSelf tickStateChange];
    }];
    [self addSubview:self.tickButton];
    self.tickButton.selected = YES;
    
    self.label = [UILabel labelWithText:self.labelStr Font:[AppSkin fontOfSize15Thin] color:self.labelColor];
    [self addSubview:self.label];
    
    self.button = [UIButton btnWithTitle:self.buttonStr Font:[AppSkin fontOfSize15Thin] color:self.buttonColor actionBlock:self.myBlock];
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

@end
