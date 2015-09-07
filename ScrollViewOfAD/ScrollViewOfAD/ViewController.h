//
//  ViewController.h
//  ScrollViewOfAD
//
//  Created by 袁红霞 on 15/7/29.
//  Copyright (c) 2015年 hongxia Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollAndPageView.h"
#define NUM 10
@interface ViewController : UIViewController<WHcrolViewViewDelegate>
{
    ScrollAndPageView * _spView;
}

@end

