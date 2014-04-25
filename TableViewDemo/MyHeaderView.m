//
//  MyHeaderView.m
//  TableViewDemo
//
//  Created by wwwins on 2014/4/24.
//  Copyright (c) 2014年 wwwins. All rights reserved.
//

#import "MyHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define IMAGE_W 318
#define IMAGE_H 128

#define BASE_URL @"http://lorempixel.com/318/128/cats/"

@implementation MyHeaderView

- (id)initWithCoder:(NSCoder *)aDecoder
{
  NSLog(@"initWithCoder");
  self = [super initWithCoder:aDecoder];
  if (self) {
    NSLog(@"initAll");
    
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      // Initialization code

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

// after nib-loading
- (void)awakeFromNib
{
  NSLog(@"awakeFromNib");
  [self initAll];
}

// custom layout
- (void)layoutSubviews
{
  [self initSubViews];
}

- (void)initAll
{
  [self initImages];
  //[self initSubViews];
  //[self startPaging];
}

- (void)initSubViews
{
  NSLog(@"initSubViews:%d",[_arrImages count]);

  _scrollView.delegate = self;
  _scrollView.showsHorizontalScrollIndicator = NO;
  _scrollView.showsVerticalScrollIndicator = NO;
  _scrollView.pagingEnabled = YES;
  _scrollView.contentSize = CGSizeMake(IMAGE_W*[_arrImages count], IMAGE_H);

  [_pageControl setNumberOfPages:[_arrImages count]];
  for(int i=0; i<[_arrImages count]; i++) {
#if 1
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,[_arrImages objectAtIndex:i]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(IMAGE_W*i, 0, IMAGE_W, IMAGE_H)];
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"previewholder"]];
    [_scrollView addSubview:imageView];
#else

    UIView *uiview = [[UIView alloc] initWithFrame:CGRectMake(IMAGE_W*i, 0, IMAGE_W, IMAGE_H)];
    uiview.backgroundColor = [[UIColor alloc] initWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    [_scrollView addSubview:uiview];
#endif

  }
  
  [_label setText:@"this is test!!"];

}

- (void)initImages
{
  _arrImages = [[NSMutableArray alloc] init];
  for (int i=0; i<5; i++) {
    [_arrImages addObject:[NSString stringWithFormat:@"%d", i]];
  }
}

#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  _pageControl.currentPage = _scrollView.contentOffset.x / IMAGE_W;

}

#pragma mark - auto-paging
- (void)startPaging
{
  [self stopPaging];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
}

-(void)stopPaging
{
  [self.timer invalidate];
  self.timer = nil;
}

#pragma mark -
- (void)handleTimer
{
  NSLog(@"handleTimer");
  CGPoint pt = _scrollView.contentOffset;
  pt.x += IMAGE_W;
  if ((pt.x>IMAGE_W*([_arrImages count]-1))) {
    pt.x = 0;
  }
  [_scrollView setContentOffset:pt animated:YES];
}

@end
