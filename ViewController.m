//
//  ViewController.m
//  FishhookDemo
//
//  Created by chenzl on 2020/8/7.
//  Copyright © 2020年 chenzl. All rights reserved.
//

#import "ViewController.h"
#import "fishhook.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Button:(id)sender{
    NSLog(@"fishing!\n");
    //hook交换方法
    //    struct rebinding {
    //        const char *name; //需要hook的函数名称，C字符串
    //        void *replacement; //新函数的地址
    //        void **replaced;  //原始函数地址的指针（二级指针）
    //    };
    struct rebinding nslog;
    nslog.name = "NSLog";
    nslog.replacement = newNSLog;
    nslog.replaced = (void *)&sys_nslog;
    
    struct rebinding rebs[1] = {nslog};
    /**
     重新绑定符号
     @param rebindings#> 存放rebingding结构体的数组 description#>
     @param rebindings_nel#> 数组的长度 description#>
     @return return value description
     */
    rebind_symbols(rebs, 1);
    printf("hook成功！\n");
}
#pragma mark - 更改系统NSLog调用
//函数指针,保存原始函数的地址
static void (*sys_nslog)(NSString *format,...);

void newNSLog(NSString *format,...){
    format = @"nofishing!";
    //format = [format stringByAppendingString:@"no fishing!"];
    sys_nslog(format);
}

@end
