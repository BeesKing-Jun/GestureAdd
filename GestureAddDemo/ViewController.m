//
//  ViewController.m
//  GestureAddDemo
//
//  Created by WJ on 15/9/23.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "ViewController.h"
#import "UIView+AddGesture.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testLabel.addOtherHandler = ^()
    {
        UITapGestureRecognizer *tapgesture = (UITapGestureRecognizer *) self.testLabel.allGesture;
        tapgesture.numberOfTapsRequired = 2;
    };
    [self.testLabel addGestureWithGestureType:tapGesture completeHandler:^{
        NSLog(@"单击处理");
    }];
    
    //添加手势
    [self.testLabel addGestureWithGestureType:tapGesture otherSettingHandler:^{
        //这里对tap手势  添加之后 一些手势的其它属性设置
        ((UITapGestureRecognizer *)self.testLabel.allGesture).numberOfTapsRequired = 2;
    } completeHandler:^{
        NSLog(@"手势点击处理");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender
{
    [self.testLabel removeGestureWithGestureType:tapGesture completHandler:^{
        NSLog(@"移除手势处理");
    }];
}


@end
