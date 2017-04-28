//
//  ViewController.m
//  LabelSwitchAnimation
//
//  Created by HJaycee on 2017/4/28.
//  Copyright © 2017年 HJaycee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UILabel *label0;
@property (nonatomic, weak) UILabel *label1;
@property (nonatomic, weak) UIView *moveView;
@property (nonatomic, weak) UIView *topView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 底部真实view
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    bottomView.center = CGPointMake(self.view.frame.size.width / 2, 200);
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bottomView];
    
    UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    label0.text = @"标签一";
    label0.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:label0];
    
    label0.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap0)];
    [label0 addGestureRecognizer:tap0];
    self.label0 = label0;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 80, 44)];
    label1.text = @"标签二";
    label1.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:label1];
    
    label1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
    [label1 addGestureRecognizer:tap1];
    self.label1 = label1;
    
    // 移动的view
    UIView *moveView = [[UIView alloc] initWithFrame:label0.frame];
    moveView.backgroundColor = [UIColor orangeColor];
    moveView.layer.cornerRadius = 22;
    moveView.clipsToBounds = YES;
    moveView.userInteractionEnabled = NO;
    [bottomView addSubview:moveView];
    self.moveView = moveView;
    
    // 高亮效果的view
    UIView *topView = [[UIView alloc] initWithFrame:bottomView.frame];
    topView.userInteractionEnabled = NO;
    [self.view addSubview:topView];
    self.topView = topView;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    label2.text = @"标签一";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    [topView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 80, 44)];
    label3.text = @"标签二";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = [UIColor whiteColor];
    [topView addSubview:label3];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTopView)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)tap0 {
    [UIView animateWithDuration:1 animations:^{
        self.moveView.frame = self.label0.frame;
    }];
}


- (void)tap1 {
    [UIView animateWithDuration:1 animations:^{
        self.moveView.frame = self.label1.frame;
    }];
}

- (void)updateTopView {
    CALayer *layer = self.moveView.layer.presentationLayer;
    if (!layer) {
        layer = self.moveView.layer;
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = layer.frame;
    CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
    maskLayer.path = path;
    CGPathRelease(path);
    self.topView.layer.mask = maskLayer;
}


@end
