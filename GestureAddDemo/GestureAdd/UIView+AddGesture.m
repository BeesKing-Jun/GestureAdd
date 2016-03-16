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
    if (!self.handleTapBlockKey) {
        self.handleTapBlockKey = completeHandler;
    }
    if (!self.addOtherHandler) {
        self.addOtherHandler = addHandler;
    }
    if (!self.allGesture) {
        switch (gestureType) {
            case tapGesture:
                self.allGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.addOtherHandler)
                {
                    self.addOtherHandler();
                }
                [self addGestureRecognizer:self.allGesture];
                break;
            case panGesture:
                self.allGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.addOtherHandler)
                {
                    self.addOtherHandler();
                }
                [self addGestureRecognizer:self.allGesture];
                break;
            case longPressGesture:
                self.allGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.addOtherHandler)
                {
                    self.addOtherHandler();
                }
                [self addGestureRecognizer:self.allGesture];
                break;
            case pinchGesture:
                self.allGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.addOtherHandler)
                {
                    self.addOtherHandler();
                }
                [self addGestureRecognizer:self.allGesture];
                break;
            case rotationGesture:
                self.allGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.addOtherHandler)
                {
                    self.addOtherHandler();
                }
                [self addGestureRecognizer:self.allGesture];
                break;
            case swipeGesture:
                self.allGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(__gestureAction:)];
                if (self.addOtherHandler)
                {
                    self.addOtherHandler();
                }
                [self addGestureRecognizer:self.allGesture];
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
        if (self.handleTapBlockKey)
        {
            self.handleTapBlockKey();
        }
    }
    if([gesture isKindOfClass:[UIPanGestureRecognizer class]])
    {
//        NSLog(@"pan手势");
        if (self.handleTapBlockKey)
        {
            self.handleTapBlockKey();
        }
    }
    if([gesture isKindOfClass:[UILongPressGestureRecognizer class]])
    {
//        NSLog(@"longPress手势");
        if (self.handleTapBlockKey)
        {
            self.handleTapBlockKey();
        }
    }
    if([gesture isKindOfClass:[UIPinchGestureRecognizer class]])
    {
//        NSLog(@"pinch手势");
        if (self.handleTapBlockKey)
        {
            self.handleTapBlockKey();
        }
    }
    if([gesture isKindOfClass:[UIRotationGestureRecognizer class]])
    {
//        NSLog(@"rotation手势");
        if (self.handleTapBlockKey)
        {
            self.handleTapBlockKey();
        }
    }
    if([gesture isKindOfClass:[UISwipeGestureRecognizer class]])
    {
//        NSLog(@"swip手势");
        if (self.handleTapBlockKey)
        {
            self.handleTapBlockKey();
        }
    }
    
}

/*
 *移除某种类型的手势
 */
- (void)removeGestureWithGestureType:(GestureType)gestureType completHandler:(void (^)(void))completeHandler
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        switch (gestureType) {
            case tapGesture:
                [self removeGestureRecognizer:gesture];
                break;
            case panGesture:
                [self removeGestureRecognizer:gesture];
                break;
            case longPressGesture:
                [self removeGestureRecognizer:gesture];
                break;
            case pinchGesture:
                [self removeGestureRecognizer:gesture];
                break;
            case rotationGesture:
                [self removeGestureRecognizer:gesture];
                break;
            case swipeGesture:
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

- (handleTapBlockKey)handleTapBlockKey
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHandleTapBlockKey:(handleTapBlockKey)handleTapBlockKey
{
    objc_setAssociatedObject(self, @selector(handleTapBlockKey), handleTapBlockKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (addOtherHandler)addOtherHandler
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAddOtherHandler:(addOtherHandler)addOtherHandler
{
    objc_setAssociatedObject(self, @selector(addOtherHandler), addOtherHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (UIGestureRecognizer *)allGesture
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAllGesture:(UIGestureRecognizer *)allGesture
{
    objc_setAssociatedObject(self, @selector(allGesture), allGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
