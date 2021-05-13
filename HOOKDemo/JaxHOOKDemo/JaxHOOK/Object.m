//
//  Object.m
//  JaxHOOK
//
//  Created by Shaobo Yan on 2021/5/13.
//

#import "Object.h"
#import <mach-o/dyld.h>
#import <DobbyX/dobby.h>

@implementation Object

// 定义指针，表示sum函数的偏移地址
static uintptr_t sumP = 0x100005F68;

// 新函数
int mySum(int a, int b) {
    NSLog(@"原有的结果是:%d", sum_p(a, b));
    return a - b;
}

// 函数指针，用于保存原来的执行流程
static int(*sum_p)(int a, int b);

+ (void)load {
    NSLog(@"HOOK到了");
    uintptr_t aslr = _dyld_get_image_vmaddr_slide(0);
    sumP += aslr;
    // HOOK sum
    DobbyHook((void *)sumP, mySum, (void *)&sum_p);
}

@end
