//
//  ViewController.m
//  JaxAPPDemo
//
//  Created by Shaobo Yan on 2021/5/13.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"正确的计算结果为：%d", sum(10, 20));
}

int sum(int a, int b) {
    return a + b;
}


@end
