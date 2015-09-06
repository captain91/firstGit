//
//  ViewController.m
//  ScrollViewOfAD
//
//  Created by 袁红霞 on 15/7/29.
//  Copyright (c) 2015年 hongxia Yuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建view
    _spView = [[ScrollAndPageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 200)];
    
    //把N张图片放到imageview上
    NSMutableArray *tempAry = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"indexx_%.2d@2x.png",i+1]];
        [tempAry addObject:imageView];
    }
    _spView.imageViewAry=tempAry;
    _spView.delegate=self;
    [_spView shouldAutoShow:YES];
    [self.view addSubview:_spView];
    
//    for (int i=1; i<num; _whview="" _whview.delegate="self;" animated="" imageview="[[UIImageView" imageview.image="[UIImage" index="" mark="" nsstring="" pragma="" pre="" self.view="" tempary="" uiimageview="" view="" whscrollandpageview=""

}
-(void)didClickPage:(ScrollAndPageView *)view atIndex:(NSInteger)index
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
