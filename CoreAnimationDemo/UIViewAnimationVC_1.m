//
//  UIViewAnimationVC_1.m
//  CoreAnimationDemo
//
//  Created by 杜文亮 on 2017/12/7.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "UIViewAnimationVC_1.h"


#define IMAGE_COUNT 3


@interface UIViewAnimationVC_1 ()
{
    UIImageView *_imageView;
    int _currentIndex;
}
@end

@implementation UIViewAnimationVC_1

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //定义图片控件
    _imageView=[[UIImageView alloc]init];
    _imageView.frame=[UIScreen mainScreen].applicationFrame;
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    _imageView.image=[UIImage imageNamed:@"0"];//默认图片
    [self.view addSubview:_imageView];
    //添加手势
    UISwipeGestureRecognizer *leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
}

#pragma mark 向左滑动浏览下一张图片
-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture
{
    [self transitionAnimation:YES];
}

#pragma mark 向右滑动浏览上一张图片
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture
{
    [self transitionAnimation:NO];
}


#pragma mark 转场动画
-(void)transitionAnimation:(BOOL)isNext
{
    UIViewAnimationOptions option;
    if (isNext)
    {
        option=UIViewAnimationOptionCurveLinear |UIViewAnimationOptionTransitionFlipFromRight;
    }
    else
    {
        option=UIViewAnimationOptionCurveEaseInOut |UIViewAnimationOptionTransitionFlipFromLeft;
    }
    
    [UIView transitionWithView:_imageView duration:1.0 options:option animations:^{
        _imageView.image=[self getImage:isNext];
    } completion:nil];
    
    /*
     *   上面的转场动画演示中，其实仅仅有一个视图UIImageView做转场动画，每次转场通过切换UIImageView的内容而已。如果有两个完全不同的视图，并且每个视图布局都很复杂，此时要在这两个视图之间进行转场可以使用+ (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(4_0)方法进行两个视图间的转场，需要注意的是默认情况下转出的视图会从父视图移除，转入后重新添加，可以通过UIViewAnimationOptionShowHideTransitionViews参数设置，设置此参数后转出的视图会隐藏（不会移除）转入后再显示。
     
     注意：转场动画设置参数完全同基本动画参数设置；同直接使用转场动画不同的是使用UIView的装饰方法进行转场动画其动画效果较少，因为这里无法直接使用私有API。
     */
}

#pragma mark 取得当前图片
-(UIImage *)getImage:(BOOL)isNext
{
    if (isNext)
    {
        _currentIndex=(_currentIndex+1)%IMAGE_COUNT;
    }
    else
    {
        _currentIndex=(_currentIndex-1+IMAGE_COUNT)%IMAGE_COUNT;
    }
    NSString *imageName=[NSString stringWithFormat:@"%i",_currentIndex];
    return [UIImage imageNamed:imageName];
}

@end
