//
//  QqcUtilityUI.m
//  QqcBaseFramework
//
//  Created by qiuqinchuan on 15/11/2.
//  Copyright © 2015年 Qqc. All rights reserved.
//

#import "QqcUtilityUI.h"
#import "QqcFontDef.h"
#import "QqcSizeDef.h"
#import "QqcColorDef.h"
#import "QqcMarginDef.h"
#import "QqcUtility.h"
#import "NSString+Qqc.h"

@implementation QqcUtilityUI

+ (UIView*)createNilDataViewTip:(CGRect)rc image:(UIImage *)img textTip:(NSString*)strTip isAlignCenter:(BOOL)bIsAlignCenter
{
    CGFloat heightView = rc.size.height;   //空数据视图高度
    CGFloat widthView = rc.size.width;     //空数据视图宽度
    CGFloat heightImg = img.size.height;   //图片高度
    CGFloat widthImg = img.size.width;     //图片宽度
    CGFloat marginLeftTip = 48;                //文字边距
    CGFloat marginTopTip = 22;                //文字边距
    
    CGFloat widthTip = widthView-2*marginLeftTip;     //文字宽度
    CGSize subtitleSize = [strTip constrainedWithFont:font_16_qqc maxSize:CGSizeMake(widthTip, CGFLOAT_MAX)].size;
    CGFloat heightTip = subtitleSize.height;  //文字高度
    if (heightTip < 21) {
        heightTip = 21;
    }
    
    CGFloat marginImageTop = (heightView-heightImg-heightTip-marginTopTip)/2;
    
    //空数据视图
    UIView* viewNilDataTip = [[UIView alloc] initWithFrame:rc];
    viewNilDataTip.backgroundColor = color_f3f3f3_qqc;
    viewNilDataTip.userInteractionEnabled = NO;
    
    //图片
    UIImageView* imageView = [[UIImageView alloc] initWithImage:img];

    imageView.frame = CGRectMake((widthView-widthImg)/2, marginImageTop, widthImg, heightImg);
    [imageView setTag:99];
    [viewNilDataTip addSubview:imageView];
    [viewNilDataTip setHidden:YES];
    
    //文字
    UILabel* lblTip = [[UILabel alloc] initWithFrame:CGRectMake(marginLeftTip, CGRectGetMaxY(imageView.frame)+marginTopTip, widthTip, heightTip)];
    lblTip.text = strTip;
    lblTip.font = font_16_qqc;
    lblTip.textColor = color_666666_qqc;
    
    if (YES == bIsAlignCenter) {
        lblTip.textAlignment = NSTextAlignmentCenter;
    }else{
        if (heightTip <= 21) {
            lblTip.textAlignment = NSTextAlignmentCenter;
        }else{
            lblTip.textAlignment = NSTextAlignmentLeft;
        }
    }
    
    [lblTip setTag:100];
    lblTip.numberOfLines = -1;
    [viewNilDataTip addSubview:lblTip];
    
    //调试使用
    /*imageView.layer.borderColor = [UIColor greenColor].CGColor;
    imageView.layer.borderWidth = 2;
    lblTip.layer.borderColor = [UIColor redColor].CGColor;
    lblTip.layer.borderWidth = 2;
    viewNilDataTip.layer.borderColor = [UIColor purpleColor].CGColor;
    viewNilDataTip.layer.borderWidth = 3;*/
    
    return viewNilDataTip;
}

+ (UIView*)createNilDataViewTip:(CGRect)rc image:(UIImage *)img textTip:(NSString*)strTip;
{
    return [QqcUtilityUI createNilDataViewTip:rc image:img textTip:strTip isAlignCenter:NO];
}


//计算价格label的位置
+ (void)machningLabel:(UILabel *)label maxSize:(CGSize)labelMaxSize
{
    //modify_by_qqc
    //CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:(CGSize) {999, label.frame.size.height}];
    
    CGSize textSize = [label.text constrainedWithFont:label.font maxSize:(CGSize) {999, label.frame.size.height}].size;
    textSize.width += 10;
    
    if (textSize.width > labelMaxSize.width*0.8f) {
        textSize.width = labelMaxSize.width*0.8f;
    }
    
    label.frame = (CGRect) {CGRectGetMaxX(label.frame)-textSize.width, label.frame.origin.y, textSize.width, label.frame.size.height};
    
    label.layer.cornerRadius = 8.0f;
    label.layer.masksToBounds = YES;
}


//移除搜索框的背景颜色
+(void)removeSearchbarBgColor:(UISearchBar*)bar
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if ([bar respondsToSelector:@selector(barTintColor)]) {
        float iosversion7_1 = 7.1;
        if (version >= iosversion7_1)
        {
            //iOS7.1
            [[[[bar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
            [bar setBackgroundColor:[UIColor clearColor]];
        }
        else
        {
            //iOS7.0
            [bar setBarTintColor:[UIColor clearColor]];
            [bar setBackgroundColor:[UIColor clearColor]];
        }
    }
    else
    {
        //iOS7.0以下
        [[bar.subviews objectAtIndex:0] removeFromSuperview];
        [bar setBackgroundColor:[UIColor clearColor]];
    }
}


//画一条直线
+(UIImageView*)drawLine:(UIView *)view rect:(CGRect)rect color:(UIColor *) color
{
    return [QqcUtilityUI returnViewByDrawLine:view rect:rect color:color isDash:NO dashWidth:0 gap:0];
}

+ (UIImageView*)drawDashLine:(UIView *)view rect:(CGRect)rect color:(UIColor *) color dashWidth:(float)dashWidth gap:(float)gap
{
    return [QqcUtilityUI returnViewByDrawLine:view rect:rect color:color isDash:YES dashWidth:dashWidth gap:gap];
}

+(UIImageView *)returnViewByDrawLine:(UIView *)view rect:(CGRect)rect color:(UIColor *) color isDash:(BOOL)isDash/*是否画虚线*/ dashWidth:(float)dashWidth gap:(float)gap
{
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    UIImageView    *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    imageView.backgroundColor = [UIColor clearColor];
    
    //绘制一条白线
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    if (!isDash)
    {
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapSquare);
    }
    else
    {
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    }
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), NO);
    
    CGFloat lengths[] = {dashWidth,gap};
    
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), r, g, b, a);
    if (isDash)
    {
        CGContextSetLineDash(UIGraphicsGetCurrentContext(), 0, lengths, 2);  //画虚线
    }
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), rect.origin.x, rect.origin.y);
    
    if (rect.size.width <= 1.0) {
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),rect.origin.x, rect.origin.y + rect.size.height);
    }else if(rect.size.height <= 1.0){
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),rect.origin.x + rect.size.width, rect.origin.y);
    }
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [imageView setTag:(1000+888)];
    [view addSubview:imageView];
    
    return imageView;
}

+ (void)showTip:(NSString*)strContent title:(NSString*)strTitle
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:strTitle message:strContent delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [av show];
}

//设置UITabBar及UINavigationBar的颜色
+ (void)setTabAndNavColorWithTabNormalColor:(UIColor*)tabNormalColor_
                          tabHighLightColor:(UIColor*)tabHighLightColor_
                                tabSelColor:(UIColor*)tabSelColor_
                               tabTintColor:(UIColor*)tabTintColor_
                               navTintColor:(UIColor*)navTintColor_
{
    //modify_by_qqc UITextAttributeTextColor -> NSForegroundColorAttributeName
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : tabNormalColor_ }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : tabHighLightColor_ }
                                             forState:UIControlStateHighlighted];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : tabSelColor_ }
                                             forState:UIControlStateSelected];
    
    
    if ([QqcBaseUtility getSystemMainVersion] >= 7)
    {
        [[UINavigationBar appearance] setBarTintColor:navTintColor_];
    }
    else
    {
        [[UINavigationBar appearance] setTintColor:navTintColor_];
    }
    
    if ([QqcBaseUtility getSystemMainVersion] >= 7)
    {
        [[UITabBar appearance] setBarTintColor:tabTintColor_];
    }
    else
    {
        [[UITabBar appearance] setTintColor:tabTintColor_];
    }
}


+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIViewController *nextResponder = [self getCurrentVCMgr];
    
    if ([nextResponder isKindOfClass:[UITabBarController class]])
    {
        id selItem = ((UITabBarController*)nextResponder).selectedViewController;
        
        if ([selItem isKindOfClass:[UINavigationController class]])
        {
            
            NSArray* array  = ((UINavigationController*)selItem).viewControllers;
            result = ((UINavigationController*)selItem).topViewController;
        }
        else if ([selItem isKindOfClass:[UIViewController class]])
        {
            result = selItem;
        }
    }
    else if ([nextResponder isKindOfClass:[UINavigationController class]])
    {
        result = ((UINavigationController*)nextResponder).topViewController;
    }
    else if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = nextResponder;
    }
    
    return result;
}


+ (UIViewController *)getCurrentVCMgr
{
    UIViewController *result = nil;
    
    UIWindow * window = [self getSafeKeyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UITabBarController class]])
    {
        result = nextResponder;
    }
    else if ([nextResponder isKindOfClass:[UINavigationController class]])
    {
        result = nextResponder;
    }
    else if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = window.rootViewController;
    }
    
    return result;
}


+ (UIWindow*)getSafeKeyWindow
{
    NSArray* arrayWindow =  [UIApplication sharedApplication].windows;
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    if (nil == keyWindow || nil == keyWindow.rootViewController || keyWindow.windowLevel != UIWindowLevelNormal)
    {
        for(UIWindow * tmpWin in arrayWindow)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                keyWindow = tmpWin;
                break;
            }
        }
    }
    
    return keyWindow;
}

+ (void)isCurrentNavigationContainThisClass:(Class)destClass block:(void(^)(BOOL bIsContact, UIViewController* vcDest))block
{
    BOOL bIsCurrentNavigationContainThisClass = NO;
    UIViewController* vcDest = nil;
    NSArray* arrayVC = [QqcUtilityUI getCurrentVC].navigationController.viewControllers;
    for (NSInteger index=arrayVC.count-1; index>=0; --index) {
        UIViewController* vc = [arrayVC objectAtIndex:index];
        if ([vc isKindOfClass:destClass]) {
            bIsCurrentNavigationContainThisClass = YES;
            vcDest = vc;
            break;
        }
    }
    
    block(bIsCurrentNavigationContainThisClass, vcDest);
}

+ (BOOL)isLastVCIsThisClass:(Class)destClass
{
    BOOL bIsLastVCIsThisClass = NO;
    UIViewController* vcDest = nil;
    NSArray* arrayVC = [QqcUtilityUI getCurrentVC].navigationController.viewControllers;
    
    if (arrayVC && arrayVC.count > 1) {
        vcDest = [arrayVC objectAtIndex:(arrayVC.count-2)];
        
        if ([vcDest isKindOfClass:destClass]) {
            bIsLastVCIsThisClass = YES;
        }
    }
    
    return bIsLastVCIsThisClass;
}

@end
