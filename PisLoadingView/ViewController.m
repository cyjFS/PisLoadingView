//
//  ViewController.m
//  PisLoadingView
//
//  Created by newegg on 15/7/20.
//  Copyright (c) 2015年 newegg. All rights reserved.
//

#import "ViewController.h"
#import "EggLoadingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    EggLoadingView *eggLoadingView = [EggLoadingView viewFromXib];
    eggLoadingView.center = self.view.center;
    [self.view addSubview:eggLoadingView];
    [eggLoadingView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
