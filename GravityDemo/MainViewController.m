//
//  MainViewController.m
//  GravityDemo
//
//  Created by 宋炬峰 on 2017/5/16.
//  Copyright © 2017年 宋炬峰. All rights reserved.
//

#import "MainViewController.h"
#import "CCDirectorIOS.h"
#import "TargetViewController.h"
#import "MyScene.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    btn.backgroundColor =[UIColor yellowColor];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(onTapBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTapBtn{
    TargetViewController* target = [TargetViewController sharedDirector];
    CCGLView* v = [CCGLView viewWithFrame:[UIScreen mainScreen].bounds];
    v.backgroundColor = [UIColor yellowColor];
    [self setView:v];
    [target runWithScene:[MyScene scene]];
    [self.navigationController pushViewController:target animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
