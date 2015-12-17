//
//  ViewController.m
//  CLCountdownView
//
//  Created by 李辉 on 15/12/17.
//  Copyright © 2015年 李辉. All rights reserved.
//

#import "ViewController.h"
#import "CLCountdownView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CLCountdownView *countdownView;

@property (weak, nonatomic) IBOutlet UILabel *blockLabel;
- (IBAction)start:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor blackColor];
    
    _countdownView.backgroundColor = [UIColor clearColor];
    _countdownView.startNumber = 5;
    _countdownView.numberFont = [UIFont fontWithName:@"DIN Condensed" size:30];
    _countdownView.numberColor = [UIColor redColor];
    
    _countdownView.finishText = @"结束";
    _countdownView.finishFont = [UIFont boldSystemFontOfSize:30];
    _countdownView.finishColor = [UIColor greenColor];
    
    _countdownView.numberChangeBlock = ^(NSInteger number){
        self.blockLabel.text = [NSString stringWithFormat:@"%ld", (long)number];
    };
    _countdownView.countDownFinishBlock = ^(){
        self.blockLabel.text = @"结束";
    };
    
    
    // 从代码中创建
    CLCountdownView *view = [[CLCountdownView alloc] initWithFrame:CGRectMake(40, 40, 100, 50)];
    [self.view addSubview:view];
    [view startCountdown];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.blockLabel.text = @"开始";
    [self.countdownView startCountdown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(UIButton *)sender {
    [self.countdownView startCountdown];
}
@end
