//
//  MyHeaderView.h
//  TableViewDemo
//
//  Created by wwwins on 2014/4/24.
//  Copyright (c) 2014年 wwwins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHeaderView : UIView<UIScrollViewDelegate>

@property NSMutableArray *arrImages;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (void)initAll;
@end
