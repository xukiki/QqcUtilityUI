//
//  QqcUtilityUI.h
//  QqcBaseFramework
//
//  Created by qiuqinchuan on 15/11/2.
//  Copyright © 2015年 Qqc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface QqcUtilityUI : NSObject

//创建无数据提示窗口
+ (UIView*)createNilDataViewTip:(CGRect)rc image:(UIImage *)img textTip:(NSString*)strTip;

+ (UIView*)createNilDataViewTip:(CGRect)rc image:(UIImage *)img textTip:(NSString*)strTip isAlignCenter:(BOOL)bIsAlignCenter;

//移除搜索框的背景颜色
+ (void)removeSearchbarBgColor:(UISearchBar*)bar;

//画线
+ (UIView*)drawLine:(UIView *)view rect:(CGRect)rect color:(UIColor *) color;

//画虚线
+ (UIView*)drawDashLine:(UIView *)view rect:(CGRect)rect color:(UIColor *) color dashWidth:(float)dashWidth gap:(float)gap;

//显示简单的弹窗提示
+ (void)showTip:(NSString*)strContent title:(NSString*)strTitle;

//设置UITabBar及UINavigationBar的颜色
+ (void)setTabAndNavColorWithTabNormalColor:(UIColor*)tabNormalColor_
                          tabHighLightColor:(UIColor*)tabHighLightColor_
                                tabSelColor:(UIColor*)tabSelColor_
                               tabTintColor:(UIColor*)tabTintColor_
                               navTintColor:(UIColor*)navTintColor_;

/**
 *  获取当前屏幕显示的viewcontroller
 *
 *  @return 当前屏幕显示的viewcontroller对象
 */
+ (UIViewController *)getCurrentVC;

/**
 *  获取当前屏幕显示的视图控制器对应的Tabbar，如无对应的Tabbar则返回对应的Navigation，如无对应的Navigation，则返回当前屏幕显示的视图控制器
 *
 *  @return 当前屏幕显示的视图控制器
 */
+ (UIViewController *)getCurrentVCMgr;

/**
 *  返回当前的KeyWindow
 *
 *  @return key window
 */
+ (UIWindow*)getSafeKeyWindow;

/**
 当前的Navigation堆栈中是否包含该类实例

 @param class 实例类
 @return 是不包含
 */
+ (void)isCurrentNavigationContainThisClass:(Class)destClass block:(void(^)(BOOL bIsContact, UIViewController* vcDest))block;

/**
 当前的Navigation堆栈中最后一个控制器是否是该类实例
 
 @param class 实例类
 @return 最后一个控制器是否是该类实例
 */
+ (BOOL)isLastVCIsThisClass:(Class)destClass;


@end
