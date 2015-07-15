//
//  ActivityViewController.m
//  CoffeeTime
//
//  Created by fule on 15/6/24.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ActivityViewController.h"
#import "Header.h"
#import "ActivityTableViewCell.h"
#import "ActivityModel.h"

@interface ActivityViewController () <ActivityTableViewCellDelete>
{
    NSMutableArray *infoArr;
    
    NSMutableArray *shengYuArr;
    float allPrice;
}

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor brownColor];
    self.navView.backgroundColor = barColor;
    [self loadTestData];
    shengYuArr = [[NSMutableArray alloc] init];
}

- (void)adjustView
{
    
    self.navigationController.navigationBarHidden=YES;
    // Tab Bar
    [self showOrHideTabBar:NO];
    
    self.allPriceLabel.text = @"请选择套餐";
    
    [self.totalPriceView setFrame:CGRectMake(self.totalPriceView.frame.origin.x, self.view.frame.size.height - self.totalPriceView.frame.size.height-64-kTabBarHeight, SCREEN_WIDTH, self.totalPriceView.frame.size.height)];
    
    self.btnDone.layer.cornerRadius = 4;
    self.btnDone.layer.masksToBounds = YES;
}

- (void)loadTestData
{
    infoArr = [[NSMutableArray alloc]init];
    for (int i=0; i<3; i++) {
        
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        [infoDict setValue:@"冰激凌大杯" forKey:@"activiyName"];
        [infoDict setValue:@"30" forKey:@"activiyPrice"];
        [infoDict setValue:@"0" forKey:@"num"];
        ActivityModel *activiyModel = [[ActivityModel alloc] initWithDict:infoDict];
        [infoArr addObject:activiyModel];
        
    }
    
    shengYuArr = infoArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [infoArr count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellID = @"CellID";
    ActivityTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellID];

    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ActivityTableViewCell" owner:nil options:nil]lastObject];
        cell.delegate=self;
    }
    
    //cell.nameLabel.text=@"星巴克拿铁咖啡(中)×1\n星巴克拿铁咖啡(中)×1";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ActivityModel*dic=infoArr[indexPath.row];
    [cell addTheValue:dic indexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

#pragma mark -- 实现加减按钮点击代理事件
/**
 *  实现加减按钮点击代理事件
 *
 *  @param cell 当前单元格
 *  @param flag 按钮标识，11 为减按钮，12为加按钮
 */
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSLog(@"%d",flag);
    int i=flag/10;//加减
    int m=flag%10;//行数
    
    if (i==1) {
        //做加法
        ActivityModel*model=infoArr[m];
        
        [infoArr removeObjectAtIndex:m];
        for (int cellIndex=0; cellIndex<infoArr.count; cellIndex++) {
            ActivityModel*model2=infoArr[cellIndex];
            model2.num=0;
        }
        
        [infoArr insertObject:model atIndex:m];
        model.num++;
        
    } else if (i==2) {
        //做减法
        ActivityModel*model=infoArr[m];
        if (model.num>0) {
            model.num--;
        }
    }
    
    [self.myTableView reloadData];
    [self totalPrice];
    
}

-(void)totalPrice
{
    for (int i=0; i<infoArr.count; i++) {
        ActivityModel*model=infoArr[i];
        allPrice = allPrice + model.num *model.activiyPrice;
    }
    
    self.allPriceLabel.text=[NSString stringWithFormat:@"￥%.2f",allPrice];
    allPrice=0.0;
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
