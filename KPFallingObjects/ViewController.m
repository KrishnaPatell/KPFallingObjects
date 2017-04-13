//
//  ViewController.m
//  KPFallingObjects
//
//  Created by Krishna on 13/04/17.
//  Copyright © 2017 Krishna Patel. All rights reserved.
//

#import "ViewController.h"
#import "KPFallingObjectView.h"
@interface ViewController ()
{
    KPFallingObjectView *obj;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self performSelector:@selector(btnNumber:) withObject:nil afterDelay:0.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnNumber:(id)sender{
    [obj endFallAnimation];
    obj = [[KPFallingObjectView alloc] initWithFrame:_viewContainer.frame];
    obj.arrFlakeFileName = [[NSMutableArray alloc] initWithObjects:@"0.png", @"1.png", @"4.png", @"6.png", @"8.png", nil];
    [_viewContainer addSubview:obj];
    [obj beginFallAnimation];
}

-(IBAction)btnAlphabet:(id)sender{
    [obj endFallAnimation];
    obj = [[KPFallingObjectView alloc] initWithFrame:_viewContainer.frame];
    obj.arrFlakeFileName = [[NSMutableArray alloc] initWithObjects:@"A.png", @"B.png", @"D.png", @"E.png", @"F.png", @"K.png", @"L.png", nil];
    [_viewContainer addSubview:obj];
    [obj beginFallAnimation];
}

-(IBAction)btnSnowFall:(id)sender{
    [obj endFallAnimation];
    obj = [[KPFallingObjectView alloc] initWithFrame:_viewContainer.frame];
    obj.arrFlakeFileName = [[NSMutableArray alloc] initWithObjects:@"Snowflake.png", nil];
    [_viewContainer addSubview:obj];
    [obj beginFallAnimation];
}

-(IBAction)btnBinary:(id)sender{
    [obj endFallAnimation];
    obj = [[KPFallingObjectView alloc] initWithFrame:_viewContainer.frame];
    obj.arrFlakeFileName = [[NSMutableArray alloc] initWithObjects:@"0_M.png", @"1_M.png", nil];
    [_viewContainer addSubview:obj];
    [obj beginFallAnimation];
}

@end
