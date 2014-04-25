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

@property MyHeaderView *myHeaderView;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  _arrDataSource1 = [[NSMutableArray alloc] init];
  for (int i=0; i<3; i++) {
    [_arrDataSource1 addObject:[NSString stringWithFormat:@"第 %d 筆", i]];
  }
  
  _arrDataSource2 = [[NSMutableArray alloc] init];
  for (int i=0; i<5; i++) {
    [_arrDataSource2 addObject:[NSString stringWithFormat:@"No:%d", i]];
  }
  
  _arrDataSource = [[NSMutableArray alloc] initWithObjects:_arrDataSource1, _arrDataSource2, nil];
  _arrSectionData = [[NSArray alloc] initWithObjects:@"category-1",@"category-2", nil ];
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;

#ifdef HEADER_IN_VIEW
  //MyHeaderView *myHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"MyHeaderView" owner:self options:nil] lastObject];
  self.myHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"MyHeaderView" owner:self options:nil] lastObject];
  self.tableView.tableHeaderView = self.myHeaderView;
#endif
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
  //label.text = [NSString stringWithFormat:@"課程標題:%d", indexPath.row];
  label.text = [[_arrDataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
  
  UIImageView *uiimageview = (UIImageView *)[cell viewWithTag:CELL_IMAGE_TAG];
  // local image
  //[uiimageview setImage:[UIImage imageNamed:@"preview.png"]];
  
  // remote image
  // @"http://lorempixel.com/400/200/cats/[1-9]"
  [uiimageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://lorempixel.com/400/200/cats/%d", 1+indexPath.row%9]] placeholderImage:[UIImage imageNamed:@"previewholder"]];

  UIButton *btn = (UIButton *)[cell viewWithTag:CELL_BUTTON_TAG];
  [btn addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
  
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

#pragma mark - header in section

#ifdef HEADER_IN_SECTION

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 128;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  MyHeaderView *myHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"MyHeaderView" owner:self options:nil] lastObject];
  return myHeaderView;

}

#endif

#pragma mark - header in view

#ifdef HEADER_IN_VIEW

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  NSLog(@"Will:%d,%d",indexPath.section,indexPath.row);
  if(indexPath.section==0 && indexPath.row==0)
    [self.myHeaderView startPaging];

}

#endif

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  NSLog(@"End:%d,%d",indexPath.section,indexPath.row);
  if(indexPath.section==0 && indexPath.row==0)
    [self.myHeaderView stopPaging];
  
}


#pragma mark - action

- (void)handleClick:(id) sender
{
  // using superview
  /*
  UITableViewCell *clickedCell = (UITableViewCell *)[[[sender superview] superview] superview];
  NSIndexPath *indexPath = [self.tableView indexPathForCell:clickedCell];
  */
  // using position
  CGPoint btnPosition = [sender convertPoint:CGPointZero toView:self.tableView];
  NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:btnPosition];
  UITableViewCell *clickedCell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
  
  NSLog(@"indexPath:%d, textLabel:%@", indexPath.row, clickedCell.textLabel.text);
  
  [self cleanAllImage];
}

- (void)cleanAllImage
{
  SDImageCache *imageCache = [SDImageCache sharedImageCache];
  [imageCache clearMemory];
  [imageCache clearDisk];
  [imageCache cleanDisk];
  
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Clean all memory and disk cache" delegate:self cancelButtonTitle:nil otherButtonTitles:@"確定", nil];
  [alertView show];
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
