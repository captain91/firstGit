//
//  ScrollAndPageView.h
//  ScrollViewOfAD
//
//  Created by 袁红霞 on 15/7/29.
//  Copyright (c) 2015年 hongxia Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WHcrolViewViewDelegate;
@interface ScrollAndPageView : UIView<UIScrollViewDelegate>
{
    __unsafe_unretained id<WHcrolViewViewDelegate>_delegate;
}
@property(nonatomic,assign)id<WHcrolViewViewDelegate>delegate;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,strong)NSMutableArray *imageViewAry;
@property(nonatomic,readonly)UIScrollView *scrollView;
@property(nonatomic,readonly)UIPageControl *pageControl;
-(void)shouldAutoShow:(BOOL)shouldStart;
@end

@protocol WHcrolViewViewDelegate <NSObject>

-(void)didClickPage:(ScrollAndPageView *)view atIndex:(NSInteger)index;

@end
