//
//  UIViewAnimationVC.m
//  CoreAnimationDemo
//
//  Created by 杜文亮 on 2017/12/7.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "UIViewAnimationVC.h"

@interface UIViewAnimationVC ()
{
    UIImageView *_imageView;
}
@end

@implementation UIViewAnimationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置背景
    UIImage *backgroundImage=[UIImage imageNamed:@"2"];
    self.view.backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    
    //创建图像显示控件
    _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    _imageView.center=CGPointMake(50, 150);
    [self.view addSubview:_imageView];
}

#pragma mark 点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=touches.anyObject;
    CGPoint location= [touch locationInView:self.view];
    
    //   ------------   UIView对基础动画的封装   ---------
    //方法1：block方式
//    [self blockAnimation:location];
    
    //方法2：静态方法
//    [self staticAnimation:location];
    
    //弹簧动画（在方法1，2的动画基础上增加了弹簧效果）
    [self springAnimation:location];
    
     //   ------------   UIView对关键帧动画的封装   ---------
//    [self keyFrameAnimation];
}

#pragma mark - 对基础的动画的封装

-(void)blockAnimation:(CGPoint)location
{
    /*开始动画，UIView的动画方法执行完后动画会停留在重点位置，而不需要进行任何特殊处理
     duration:执行时间
     delay:延迟时间
     options:动画设置，例如自动恢复、匀速运动等
     completion:动画完成回调方法
     */
    [UIView animateWithDuration:5.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^
    {
        _imageView.center=location;
    }
    completion:^(BOOL finished)
    {
        NSLog(@"Animation end.");
    }];
    
    /*
     *   在动画方法中有一个option参数，UIViewAnimationOptions类型，它是一个枚举类型，动画参数分为三类，可以组合使用：
     
     1.常规动画属性设置（可以同时选择多个进行设置）
     
        UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
     
        UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
     
        UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
     
        UIViewAnimationOptionRepeat：重复运行动画。
     
        UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。
     
        UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
     
        UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。
     
        UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。
     
        UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
        
        UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
     
     2.动画速度控制（可从其中选择一个设置）
     
        UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
     
        UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。
     
        UIViewAnimationOptionCurveEaseOut：动画逐渐加速。
     
        UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。
     
     3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
     
        UIViewAnimationOptionTransitionNone：没有转场动画效果。
     
        UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。
     
        UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。
     
        UIViewAnimationOptionTransitionCurlUp：向后翻页的动画过渡效果。
     
        UIViewAnimationOptionTransitionCurlDown ：向前翻页的动画过渡效果。
     
        UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。
     
        UIViewAnimationOptionTransitionFlipFromTop ：从上方翻转效果。
     
        UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。
     */
}

-(void)staticAnimation:(CGPoint)location
{
    //开始动画
    [UIView beginAnimations:@"KCBasicAnimation" context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelay:1.0];//设置延迟
    [UIView setAnimationRepeatAutoreverses:NO];//是否动画恢复原始位置
    [UIView setAnimationRepeatCount:3];//重复次数
    //    [UIView setAnimationStartDate:(NSDate *)];//设置动画开始运行的时间
    
    //只有设置了代理，下面动画开始和结束才会调用相应的方法
    //    [UIView setAnimationDelegate:self];//设置代理
    //    [UIView setAnimationWillStartSelector:(@selector(startAnimation))];//设置动画开始运动的执行方法
    //    [UIView setAnimationDidStopSelector:(@selector(endAnimation))];//设置动画运行结束后的执行方法
    
    
    _imageView.center=location;
    //开始动画
    [UIView commitAnimations];
}

-(void)startAnimation
{
    NSLog(@"start!");
}

-(void)endAnimation
{
    NSLog(@"end!");
}

-(void)springAnimation:(CGPoint)location
{
    /*创建弹性动画
     damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
     velocity:弹性复位的速度
     */
    [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveLinear animations:^
    {
        _imageView.center=location;
    } completion:nil];
}

#pragma mark - 对关键帧动画的封装

-(void)keyFrameAnimation
{
    [UIView animateKeyframesWithDuration:3.0 delay:0 options: UIViewAnimationOptionRepeat |  UIViewKeyframeAnimationOptionCalculationModeLinear animations:^
    {
        //第二个关键帧（准确的说第一个关键帧是开始位置）:从0秒开始持续50%的时间，也就是5.0*0.5=2.5秒
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            _imageView.center=CGPointMake(80.0, 220.0);
        }];
        //第三个关键帧，从0.5*5.0秒开始，持续5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            _imageView.center=CGPointMake(45.0, 300.0);
        }];
        //第四个关键帧：从0.75*5.0秒开始，持所需5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            _imageView.center=CGPointMake(55.0, 400.0);
        }];
        
    }
    completion:^(BOOL finished)
    {
        NSLog(@"Animation end.");
    }];
    
    /*
     *   对于关键帧动画也有一些动画参数设置options，UIViewKeyframeAnimationOptions类型，和上面基本动画参数设置有些差别，关键帧动画设置参数分为两类，可以组合使用：
     
     1.常规动画属性设置（可以同时选择多个进行设置）
     
        UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
     
        UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
     
        UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
     
        UIViewAnimationOptionRepeat：重复运行动画。
     
        UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。
     
        UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
        
        UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
     
     2.动画模式设置（同前面关键帧动画动画模式一一对应，可以从其中选择一个进行设置）
     
        UIViewKeyframeAnimationOptionCalculationModeLinear：连续运算模式。
     
        UIViewKeyframeAnimationOptionCalculationModeDiscrete ：离散运算模式。
     
        UIViewKeyframeAnimationOptionCalculationModePaced：均匀执行运算模式。
     
        UIViewKeyframeAnimationOptionCalculationModeCubic：平滑运算模式。
     
        UIViewKeyframeAnimationOptionCalculationModeCubicPaced：平滑均匀运算模式。
     
     注意：前面说过关键帧动画有两种形式，上面演示的是属性值关键帧动画，路径关键帧动画目前UIView还不支持。
     */
}

@end
