//
//  ViewController.m
//  MsgSendDemo
//
//  Created by 张忠瑞 on 2018/2/8.
//  Copyright © 2018年 张忠瑞. All rights reserved.
//

#import "ViewController.h"
#import "EOCAutoDictionary.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    EOCAutoDictionary *dict = [[EOCAutoDictionary alloc] init];
    dict.date = [NSDate dateWithTimeIntervalSince1970:475372800];
    NSLog(@"dict.date = %@",dict.date);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
