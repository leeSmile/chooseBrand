//
//  ViewController.m
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/5.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ViewController.h"
#import "ChooseCarController.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)click:(UIButton *)sender {
    NSLog(@"点击");
    
    ChooseCarController *VC= [[ChooseCarController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

@end
