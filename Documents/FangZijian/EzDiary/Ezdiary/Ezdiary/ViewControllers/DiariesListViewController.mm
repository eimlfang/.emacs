//
//  DiariesListViewController.m
//  Ezdiary
//
//  Created by Besprout's Mac Mini on 15/12/14.
//  Copyright © 2015年 Fang Zijian. All rights reserved.
//

#import "DiariesListViewController.h"
#import "DateManager.hpp"
#import "NSString+Category.h"

using namespace std;

@interface DiariesListViewController ()
{
    int _selectedMonth;
}
@end

@implementation DiariesListViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    tm* now = DateManagerInstance->now();
    printf("%d - %d - %d\n",now->tm_year+ 1900, (now->tm_mon + 1),now->tm_mday);
}
#pragma mark - Property Getter&Setter

#pragma mark - Event response

#pragma mark - Network request

#pragma mark - Delegate

#pragma mark - Data handle

#pragma mark - Dealloc
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kDiariesCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Diaries%ld",(long)indexPath.row];
    
    return cell;
}

#pragma mark Table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    self.title = cell.textLabel.text;
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ooops" message:@"The memory of life can't be deleted" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:NULL];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
