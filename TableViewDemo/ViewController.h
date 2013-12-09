//
//  ViewController.h
//  TableViewDemo
//
//  Created by wwwins on 2013/11/13.
//  Copyright (c) 2013年 wwwins. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_LABEL_TAG   101
#define CELL_BUTTON_TAG  102
#define CELL_IMAGE_TAG   103

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
