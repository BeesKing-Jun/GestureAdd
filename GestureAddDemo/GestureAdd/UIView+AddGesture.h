//
//  UIView+AddGesture.h
//  GestureAddDemo
//
//  Created by WJ on 15/9/23.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *对手势类型进行枚举
 */
typedef NS_ENUM(NSInteger,GestureType)
{
    WJ_TapGesture                = 0,      //单击手势
    WJ_PanGesture                = 1,      //拖移，慢速移动
    WJ_LongPressGesture          = 2,      //长按
    WJ_PinchGesture              = 3,      //二指往內或往外拨动，平时经常用到的缩放
    WJ_RotationGesture           = 4,      //旋转
    WJ_SwipeGesture              = 5,      //滑动，快速移动
};

typedef void(^GestureHandler)(void);
typedef void(^AddOtherHandler)(void);


@interface UIView (AddGesture)
/*
 *所有手势类型
 */
@property (nonatomic, strong) UIGestureRecognizer *WJ_allGesture;
/*
 *手势操作
 */
@property (nonatomic, copy) GestureHandler WJ_gestureHandler;

/*
 *手势其它操作
 */
@property (nonatomic, copy) AddOtherHandler WJ_addOtherHandler;

/*
 *添加某种类型手势,注意block 里面需要弱引用，self强引用了block，block强引用self会有retain cycle
 *@prama gestureType 手势类型
 *@prama addHandler 添加手势时的其他设置
 *@prama completeHandler 手势操作处理
 */
- (void)addGestureWithGestureType:(GestureType)gestureType
              otherSettingHandler:(void(^)(void))addHandler
                  completeHandler:(void (^)(void))completeHandler;
/*
 *添加某种类型手势,注意block 里面需要弱引用，self强引用了block，block强引用self会有retain cycle
 *@prama gestureType 手势类型
 *@prama completeHandler 手势操作处理
 */
- (void)addGestureWithGestureType:(GestureType)gestureType
                  completeHandler:(void (^)(void))completeHandler;
/*
 *移除某种手势,注意block 里面需要弱引用，self强引用了block，block强引用self会有retain cycle
 *@prama gestureType 手势类型
 *@prama completeHandler 移除手势时做的操作
 */
- (void)removeGestureWithGestureType:(GestureType)gestureType completeHandler:(void (^)(void))completeHandler;
/*
 *移除所有手势,注意block 里面需要弱引用，self强引用了block，block强引用self会有retain cycle
 *@prama completeHandler 移除手势时做的操作
 */
- (void)removeAllGesture:(void (^)(void))completeHandler;

@end
