//
//  ViewController.m
//  仿QQ好友列表
//
//  Created by qzp on 16/3/15.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, strong) NSMutableArray * lists;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.dataSource = [[NSMutableArray alloc] init];
    self.lists = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        [self.dataSource addObject: @"0"];
        [self.lists addObject: [NSString stringWithFormat:@"%d",i + 1]];
    }
    
    self.dataSource[0] = @"1";
    
    
    
    [self initializeUserInteface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) initializeUserInteface {
    
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStylePlain];
    [self.view addSubview: self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [UIView new];
    

}


#pragma mark -UITableViewDelgate-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger temp = [self.dataSource[section] integerValue] == 0 ? 0 : [self.lists[section] integerValue];
    
    return temp;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
       
    }
     cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton * btn = [[UIButton alloc] initWithFrame:
                      CGRectMake(0, 5, CGRectGetWidth(self.view.bounds), 40-10)];
    btn.backgroundColor = [UIColor grayColor];
    btn.tag = section;
    [btn addTarget: self action: @selector(buttonClick:) forControlEvents: UIControlEventTouchUpInside];
    return btn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}



- (void) buttonClick: (UIButton *) button {
    NSLog(@"%d",button.tag);
    BOOL old = [self.dataSource[button.tag] boolValue];
    old = ! old;
    
    self.dataSource[button.tag] = [NSNumber numberWithBool: old];
    
    
  
//    [self.tableView reloadData];
    
    NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex: button.tag];
    
    [self.tableView reloadSections: indexSet withRowAnimation: UITableViewRowAnimationFade];

    
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
}
@end
