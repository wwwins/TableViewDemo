//
//  ViewController.m
//  TableViewDemo
//
//  Created by wwwins on 2013/11/13.
//  Copyright (c) 2013年 wwwins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//NSArray creates static arrays
//@property NSArray *arrDataSource;
@property NSArray *arrSectionData;

//NSMutable creates dynamic arrays
@property NSMutableArray *arrDataSource;
@property NSMutableArray *arrDataSource1;
@property NSMutableArray *arrDataSource2;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  _arrDataSource1 = [[NSMutableArray alloc] init];
  for (int i=0; i<30; i++) {
    [_arrDataSource1 addObject:[NSString stringWithFormat:@"第 %d 筆", i]];
  }
  
  _arrDataSource2 = [[NSMutableArray alloc] init];
  for (int i=0; i<50; i++) {
    [_arrDataSource2 addObject:[NSString stringWithFormat:@"No:%d", i]];
  }
  
  _arrDataSource = [[NSMutableArray alloc] initWithObjects:_arrDataSource1, _arrDataSource2, nil];
  _arrSectionData = [[NSArray alloc] initWithObjects:@"category-1",@"category-2", nil ];
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [_arrDataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[_arrDataSource objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *cellIdentifier = @"MyReuseCellIdentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if(!cell){
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  cell.textLabel.text = [[_arrDataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
  //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  UILabel *label = (UILabel *)[cell viewWithTag:CELL_LABEL_TAG];
  label.text = [NSString stringWithFormat:@"課程標題:%d", indexPath.row];
  
  UIImageView *uiimageview = (UIImageView *)[cell viewWithTag:CELL_IMAGE_TAG];
  [uiimageview setImage:[UIImage imageNamed:@"preview.png"]];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  NSString *output = [[_arrDataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
  NSLog(@"%@", output);
//  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"輸出" message:output delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"確定", nil];
//  [alertView show];
  
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

  return _arrSectionData[section];
  /*
  switch (section) {
    case 0:
      return @"category-1";
      break;
      
    case 1 :
      return @"category-2";
      break;
      
    default:
      return @"";
      break;
  }
   */
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
