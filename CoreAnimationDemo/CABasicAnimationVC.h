//
//  ViewController.h
//  CoreAnimationDemo
//
//  Created by 杜文亮 on 2017/12/5.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CABasicAnimationVC : UIViewController

/*
    CAAnimation包括CAPropertyAnimation、CAAnimationGroup和CATransition
 
    1，CAAnimation：核心动画的基础类，不能直接使用，负责动画运行时间、速度的控制，本身实现了CAMediaTiming协议。
 
    2，CAPropertyAnimation：属性动画的基类（通过属性进行动画设置，注意是可动画属性），不能直接使用。
 
        2.1，CABasicAnimation：基础动画，通过属性修改进行动画参数控制，只有初始状态和结束状态。
 
        2.2，CAKeyframeAnimation：关键帧动画，同样是通过属性进行动画参数控制，但是同基础动画不同的是它可以有多个状态控制。
 
    3，CAAnimationGroup：动画组，动画组是一种组合模式设计，可以通过动画组来进行所有动画行为的统一控制，组中所有动画效果可以并发执行。
 
    4，CATransition：转场动画，主要通过滤镜进行动画效果设置。
 */

@end

