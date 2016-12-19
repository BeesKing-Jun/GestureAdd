//
//  UIView+AddGesture.m
//  GestureAddDemo
//
//  Created by WJ on 15/9/23.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "UIView+AddGesture.h"
#import <objc/runtime.h>


@implementation UIView (AddGesture)

- (void)addGestureWithGestureType:(GestureType)gestureType
                  completeHandler:(void (^)(void))completeHandler
{
    [self addGestureWithGestureType:gestureType otherSettingHandler:nil completeHandler:completeHandler];
}

/*
 *添加某种类型的手势
 */
- (void)addGestureWithGestureType:(GestureType)gestureType
              otherSettingHandler:(void(^)(void))addHandler
                  completeHandler:(void (^)(void))completeHandler
{
    self.userInteractionEnabled = YES;
    if (!self.WJ_gestureHandler) {
        self.WJ_gestureHandler = completeHandler;
    }
    if (!self.WJ_addOtherHandler) {
        self.WJ_addOtherHandler = addHandler;
    }
    if (!self.WJ_allGesture) {
        switch (gestureType) {
            case WJ_TapGesture:
                [self removeGestureWithGestureType:WJ_TapGesture completeHandler:^{
                    
                }];
                self.WJ_allGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.WJ_addOtherHandler)
                {
                    self.WJ_addOtherHandler();
                }
                [self addGestureRecognizer:self.WJ_allGesture];
                break;
            case WJ_PanGesture:
                self.WJ_allGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.WJ_addOtherHandler)
                {
                    self.WJ_addOtherHandler();
                }
                [self addGestureRecognizer:self.WJ_allGesture];
                break;
            case WJ_LongPressGesture:
                self.WJ_allGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.WJ_addOtherHandler)
                {
                    self.WJ_addOtherHandler();
                }
                [self addGestureRecognizer:self.WJ_allGesture];
                break;
            case WJ_PinchGesture:
                self.WJ_allGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.WJ_addOtherHandler)
                {
                    self.WJ_addOtherHandler();
                }
                [self addGestureRecognizer:self.WJ_allGesture];
                break;
            case WJ_RotationGesture:
                self.WJ_allGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.WJ_addOtherHandler)
                {
                    self.WJ_addOtherHandler();
                }
                [self addGestureRecognizer:self.WJ_allGesture];
                break;
            case WJ_SwipeGesture:
                self.WJ_allGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.WJ_addOtherHandler)
                {
                    self.WJ_addOtherHandler();
                }
                [self addGestureRecognizer:self.WJ_allGesture];
                break;
                
                
            default:
                break;
        }
    }
}

/*
 *手势操作
 */
- (void)__gestureAction:(UIGestureRecognizer *)gesture
{
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        //这是单击手势
        //        NSLog(@"单击手势");
        if (self.WJ_gestureHandler)
        {
            self.WJ_gestureHandler();
        }
    }
    if([gesture isKindOfClass:[UIPanGestureRecognizer class]])
    {
        //        NSLog(@"pan手势");
        if (self.WJ_gestureHandler)
        {
            self.WJ_gestureHandler();
        }
    }
    if([gesture isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        //        NSLog(@"longPress手势");
        if (self.WJ_gestureHandler)
        {
            self.WJ_gestureHandler();
        }
    }
    if([gesture isKindOfClass:[UIPinchGestureRecognizer class]])
    {
        //        NSLog(@"pinch手势");
        if (self.WJ_gestureHandler)
        {
            self.WJ_gestureHandler();
        }
    }
    if([gesture isKindOfClass:[UIRotationGestureRecognizer class]])
    {
        //        NSLog(@"rotation手势");
        if (self.WJ_gestureHandler)
        {
            self.WJ_gestureHandler();
        }
    }
    if([gesture isKindOfClass:[UISwipeGestureRecognizer class]])
    {
        //        NSLog(@"swip手势");
        if (self.WJ_gestureHandler)
        {
            self.WJ_gestureHandler();
        }
    }
}

/*
 *移除某种类型的手势
 */
- (void)removeGestureWithGestureType:(GestureType)gestureType completeHandler:(void (^)(void))completeHandler
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        switch (gestureType) {
            case WJ_TapGesture:
                [self removeGestureRecognizer:gesture];
                break;
            case WJ_PanGesture:
                [self removeGestureRecognizer:gesture];
                break;
            case WJ_LongPressGesture:
                [self removeGestureRecognizer:gesture];
                break;
            case WJ_PinchGesture:
                [self removeGestureRecognizer:gesture];
                break;
            case WJ_RotationGesture:
                [self removeGestureRecognizer:gesture];
                break;
            case WJ_SwipeGesture:
                [self removeGestureRecognizer:gesture];
                break;
                
            default:
                break;
        }
    }
    if (completeHandler)
    {
        completeHandler();
    }
}

/*
 *移除所有手势
 */
- (void)removeAllGesture:(void (^)(void))completeHandler
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        [self removeGestureRecognizer:gesture];
    }
    if (completeHandler)
    {
        NSLog(@"这里所有手势已经移除");
        completeHandler();
    }
}

#pragma mark -- getter And Setter

- (GestureHandler)WJ_gestureHandler
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWJ_gestureHandler:(GestureHandler)WJ_gestureHandler
{
    objc_setAssociatedObject(self, @selector(WJ_gestureHandler), WJ_gestureHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (AddOtherHandler)WJ_addOtherHandler
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWJ_addOtherHandler:(AddOtherHandler)WJ_addOtherHandler
{
    objc_setAssociatedObject(self, @selector(WJ_addOtherHandler), WJ_addOtherHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIGestureRecognizer *)WJ_allGesture
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWJ_allGesture:(UIGestureRecognizer *)WJ_allGesture
{
    objc_setAssociatedObject(self, @selector(WJ_allGesture), WJ_allGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
