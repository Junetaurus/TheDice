//
//  ViewController.m
//  TheDice
//
//  Created by ZhangJun on 2017/6/1.
//  Copyright © 2017年 ZhangJun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *diceView;
@property (nonatomic, assign) CGPoint diceAngle;
@property (nonatomic, assign) CGFloat diceWH;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    [self addDiceView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addDiceView
{
    self.diceView = [[UIView alloc] init];
    [self.view addSubview:self.diceView];
    //panGesture
    UIPanGestureRecognizer *panGesture= [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewTransform:)];
    [self.diceView addGestureRecognizer:panGesture];
    
    CATransform3D diceTransform =CATransform3DIdentity;
    //dice1
    UIImageView *dice1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dice1"]];
    [dice1 sizeToFit];
    self.diceWH = dice1.frame.size.width / 2;
    dice1.frame = CGRectMake(0, 0, self.diceWH, self.diceWH);
    diceTransform = CATransform3DTranslate(diceTransform, 0, 0, dice1.frame.size.width / 2);
    dice1.layer.transform = diceTransform;
    [self.diceView addSubview:dice1];
    
    //dice6
    UIImageView *dice6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dice6"]];
    dice6.frame = dice1.bounds;
    diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, -(dice6.frame.size.width / 2));
    dice6.layer.transform = diceTransform;
    [self.diceView addSubview:dice6];

    //dice2
    UIImageView *dice2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dice2"]];
    dice2.frame = dice1.bounds;
    diceTransform = CATransform3DRotate(CATransform3DIdentity, (M_PI / 2), 0, 1, 0);
    diceTransform = CATransform3DTranslate(diceTransform, 0, 0, dice2.frame.size.width / 2);
    dice2.layer.transform = diceTransform;
    [self.diceView addSubview:dice2];
    
    //dice5
    UIImageView *dice5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dice5"]];
    dice5.frame = dice1.bounds;
    diceTransform = CATransform3DRotate(CATransform3DIdentity, -(M_PI / 2), 0, 1, 0);
    diceTransform = CATransform3DTranslate(diceTransform, 0, 0, dice5.frame.size.width / 2);
    dice5.layer.transform = diceTransform;
    [self.diceView addSubview:dice5];
    
    //dice3
    UIImageView *dice3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dice3"]];
    dice3.frame = dice1.bounds;
    diceTransform = CATransform3DRotate(CATransform3DIdentity, -(M_PI / 2), 1, 0, 0);
    diceTransform = CATransform3DTranslate(diceTransform, 0, 0, dice3.frame.size.width / 2);
    dice3.layer.transform = diceTransform;
    [self.diceView addSubview:dice3];
    
    //dice4
    UIImageView *dice4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dice4"]];
    dice4.frame = dice1.bounds;
    diceTransform = CATransform3DRotate(CATransform3DIdentity, (M_PI / 2), 1, 0, 0);
    diceTransform = CATransform3DTranslate(diceTransform, 0, 0, dice4.frame.size.width / 2);
    dice4.layer.transform = diceTransform;
    [self.diceView addSubview:dice4];
    
    //
    self.diceView.frame = CGRectMake(0.5 * ([UIScreen mainScreen].bounds.size.width - self.diceWH), 0.5 * ([UIScreen mainScreen].bounds.size.height - self.diceWH), self.diceWH, self.diceWH);
}

- (void)viewTransform:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture translationInView:self.diceView];
    CGFloat angleX = self.diceAngle.x + (point.x / 30);
    CGFloat angleY = self.diceAngle.y + (point.y / 30);
    
    CATransform3D transform =CATransform3DIdentity;
    transform.m34 = -1 / 500;
    transform = CATransform3DRotate(transform, angleX, 0, 1, 0);
    transform = CATransform3DRotate(transform, angleY, 1, 0, 0);
    self.diceView.layer.sublayerTransform = transform;
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        self.diceAngle = CGPointMake(angleX, angleY);
    }
}

@end
