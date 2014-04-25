//
//  ViewController.h
//  TableViewDemo
//
//  Created by wwwins on 2013/11/13.
//  Copyright (c) 2013年 wwwins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "MyHeaderView.h"

#define CELL_LABEL_TAG   101
#define CELL_BUTTON_TAG  102
#define CELL_IMAGE_TAG   103

#define HEADER_IN_VIEW
//#define HEADER_IN_SECTION

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
