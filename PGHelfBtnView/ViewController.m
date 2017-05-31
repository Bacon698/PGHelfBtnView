//
//  ViewController.m
//  PGHelfBtnView
//
//  Created by 张培根 on 2017/5/17.
//  Copyright © 2017年 张培根. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet PGHalfButtonView *halfButtonView;

@property (strong, nonatomic) PGHalfButtonView *halfButtonViewB;
@property (strong, nonatomic) PGHalfButtonView *halfButtonViewC;

@property (strong, nonatomic) UIButton *nextStepButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.halfButtonView setText:@"已有账号？去" color:[UIColor grayColor] Text:@"登录" color:[UIColor orangeColor] action:^(UIButton *button) {
        NSLog(@"xib点击登录");
        [self alertWithTitle:@"xib点击登录"];
    }];
    
    self.halfButtonViewB = [[PGHalfButtonView alloc]initWithText:@"已有账号？去" color:[UIColor grayColor] Text:@"登录" color:[UIColor orangeColor] font:nil action:^(UIButton *button) {
        NSLog(@"代码点击登录");
        [self alertWithTitle:@"代码点击登录"];
    }];
    [self.view addSubview:self.halfButtonViewB];
    [self.halfButtonViewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.halfButtonView.mas_bottom).offset(20);
        make.left.equalTo(self.halfButtonView);
    }];
    
    self.halfButtonViewC = [[PGHalfButtonView alloc]initWithProtocolText:@"我已阅读并同意" Text:@"《xxoo协议》" action:^(UIButton *button) {
        NSLog(@"点击协议");
        [self alertWithTitle:@"点击协议"];
    }];
    self.halfButtonViewC.tickState = tickUnselected;//显示对号框，可以设置其选中状态
    [self.view addSubview:self.halfButtonViewC];
    [self.halfButtonViewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.halfButtonViewB.mas_bottom).offset(20);
        make.left.equalTo(self.halfButtonView);
    }];
    
    self.nextStepButton = [UIButton btnWithActionBlock:^(UIButton *button) {
        
    }];
    [self.nextStepButton setTitle:@"我还不能点😭" forState:UIControlStateDisabled];
    [self.nextStepButton setTitle:@"我可以点了,快点!快点!" forState:UIControlStateNormal];
    self.nextStepButton.enabled = NO;
    [self.nextStepButton setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:self.nextStepButton];
    [self.nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.halfButtonViewC.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.width.mas_equalTo(30);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateChagne) name:PGHalfStateChange object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)alertWithTitle:(NSString *)title{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}

-(void)stateChagne{
    if (self.halfButtonViewC.tickState == tickSelected) {
        self.nextStepButton.enabled = YES;
    }else{
        self.nextStepButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
