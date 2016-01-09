//
//  ViewController.m
//  Masonry
//
//  Created by 000 on 15/9/9.
//  Copyright (c) 2015年 000. All rights reserved.
//

#import "ViewController.h"
#import "DemoOneViewController.h"
#import "DemoTwoViewController.h"
#import "DemoThreeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.DemoOne = [[UIButton alloc] init];
    self.DemoOne.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-50, [UIScreen mainScreen].bounds.size.height/2 -200, 100, 40);
    [self.DemoOne setTitle:@"DemoOne" forState:UIControlStateNormal];
    [self.view addSubview:self.DemoOne];
    
    //    self.DemoOne.frame = CGRectMake(10, 120, 300, 50);
    //    self.DemoOne.titleLabel.text = @"DemoOne";
    
    self.DemoTwo = [[UIButton alloc] init];
    self.DemoTwo.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-50, [UIScreen mainScreen].bounds.size.height/2, 100, 40);
//    self.DemoTwo.titleLabel.text = @"DemoTwo";
    [self.DemoTwo setTitle:@"DemoTwo" forState:UIControlStateNormal];
    self.DemoTwo.titleLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.DemoTwo];
    
    self.DemoThree = [[UIButton alloc] init];
    self.DemoThree.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-50, [UIScreen mainScreen].bounds.size.height/2 + 200, 100, 40);
//    self.DemoThree.titleLabel.text = @"DemoThree";
    [self.DemoThree setTitle:@"DemoThree" forState:UIControlStateNormal];
    [self.view addSubview:self.DemoThree];
    
    [self.DemoOne addTarget:self action:@selector(demoOneClick:) forControlEvents:UIControlEventTouchDown];
    [self.DemoTwo addTarget:self action:@selector(demoTwoClick:) forControlEvents:UIControlEventTouchDown];
    [self.DemoThree addTarget:self action:@selector(demoThreeClick:) forControlEvents:UIControlEventTouchDown];
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(void)pushViewController:(UIViewController *)viewController
{
  
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)demoOneClick:(UIButton *)btn
{
    DemoOneViewController *demoVC = [[DemoOneViewController alloc] init];
    [self pushViewController:demoVC];
}

-(void)demoTwoClick:(UIButton *)btn
{
    DemoTwoViewController *demoVC = [[DemoTwoViewController alloc] init];
    [self pushViewController:demoVC];
}

-(void)demoThreeClick:(UIButton *)btn
{
    DemoThreeViewController *demoVC = [[DemoThreeViewController alloc] init];
    [self pushViewController:demoVC];
}
@end
