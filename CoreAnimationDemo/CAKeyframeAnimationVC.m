//
//  CABasicAnimation.m
//  CoreAnimationDemo
//
//  Created by 杜文亮 on 2017/12/6.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "CAKeyframeAnimationVC.h"

@interface CAKeyframeAnimationVC ()
{
    CALayer *_layer;
}
@end

@implementation CAKeyframeAnimationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //设置背景(注意这个图片其实在根图层)
    UIImage *backgroundImage = [UIImage imageNamed:@"2"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    //自定义一个图层
    _layer=[[CALayer alloc]init];
    _layer.bounds=CGRectMake(0, 0, 20, 30);
    _layer.position=CGPointMake(50, 150);
    _layer.contents=(id)[UIImage imageNamed:@"1"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    [self translationAnimation_key];
}

#pragma mark - 和基础动画使用完全类似，不在一一演示，参考基础动画即可

//关键帧动画开发分为两种形式：一种是通过设置不同的属性值进行关键帧控制，另一种是通过绘制路径进行关键帧控制。后者优先级高于前者，如果设置了路径则属性值就不再起作用。
-(void)translationAnimation_key
{
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    
    //2.设置关键帧,这里有四个关键帧
    NSValue *key1=[NSValue valueWithCGPoint:_layer.position];//对于关键帧动画初始值不能省略
    NSValue *key2=[NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key3=[NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *key4=[NSValue valueWithCGPoint:CGPointMake(55, 400)];
    NSArray *values=@[key1,key2,key3,key4];
    keyframeAnimation.values=values;
    keyframeAnimation.keyTimes = @[@(0.0),@(0.8),@(0.9),@(1.0)];
    
    //2.设置路径
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);//移动到起始点
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
    keyframeAnimation.path=path;//设置path属性
    CGPathRelease(path);//释放路径对象
    
    //设置其他属性
    keyframeAnimation.duration=8.0;
    keyframeAnimation.beginTime=CACurrentMediaTime()+2;//设置延迟2秒执行
    
    
    //3.添加动画到图层，添加动画后就会执行动画
    [_layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
}

@end
