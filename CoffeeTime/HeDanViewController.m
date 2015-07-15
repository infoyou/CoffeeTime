//
//  HeDanViewController.m
//  CoffeeTime
//
//  Created by fule on 15/7/7.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "HeDanViewController.h"
#import "Header.h"
#import "HeDanTableViewCell.h"

@interface HeDanViewController ()

@end

@implementation HeDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView.backgroundColor=barColor;
    self.navigationController.navigationBarHidden=YES;

    // Tab Bar
    [self showOrHideTabBar:NO];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableView的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segMent.selectedSegmentIndex==0) {
        return 1;
    }else{
        return 3;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segMent.selectedSegmentIndex==0) {
        static NSString *CellID = @"CellID";
        UITableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            //cell = [[[NSBundle mainBundle]loadNibNamed:@"ActivityTableViewCell" owner:nil options:nil]lastObject];
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
            
        }
        cell.textLabel.text=@"星巴克拿铁咖啡(中)×1";
        cell.textLabel.font=[UIFont fontWithName:@"Arial" size:13];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        static NSString *CellID2 = @"CellID2";
        HeDanTableViewCell*cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID2];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HeDanTableViewCell" owner:nil options:nil]lastObject];
            //cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    
    }
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segMent.selectedSegmentIndex==0) {
        return 20;
    }else{
        return 103;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.segMent.selectedSegmentIndex==0) {
        return 25;
    }else{
        return 0.1;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.segMent.selectedSegmentIndex==0) {
        return 220;
    }else{
        return 0.01;
    }

    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.segMent.selectedSegmentIndex==0) {
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 180, 20)];
        label.text=@"订单编号:154856541546";
        label.font=[UIFont fontWithName:@"Arial" size:13];
        [view addSubview:label];
        
        UILabel*label2=[[UILabel alloc]initWithFrame:CGRectMake(230, 0, 80, 25)];
        label2.text=@"正在配送";
        [label2 setTextColor:[UIColor redColor]];
        label2.font=[UIFont fontWithName:@"Arial" size:18];
        [view addSubview:label2];
        return view;

    }else{
    
        return nil;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.segMent.selectedSegmentIndex==0) {
//        [testBtn.layer setMasksToBounds:YES];
//        [testBtn.layer setCornerRadius:8.0]; //设置矩圆角半径
//        [testBtn.layer setBorderWidth:1.0];   //边框宽度
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
//        [testBtn.layer setBorderColor:colorref];//边框颜色
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HeDanFootView" owner:self options:nil];
        UIView *footView = [nib objectAtIndex:0];
        footView.frame=CGRectMake(0, 0, 320, 220);
        UIButton*lianXiButton=(UIButton*)[footView viewWithTag:100];
        //lianXiButton.backgroundColor=[UIColor redColor];
        lianXiButton.layer.masksToBounds=YES;
        lianXiButton.layer.cornerRadius=4;
        lianXiButton.layer.borderColor=[[UIColor blackColor]CGColor];
        lianXiButton.layer.borderWidth=1;
        
        UIButton*cuiDanButton=(UIButton*)[footView viewWithTag:200];
        //lianXiButton.backgroundColor=[UIColor redColor];
        cuiDanButton.layer.masksToBounds=YES;
        cuiDanButton.layer.cornerRadius=4;
        cuiDanButton.layer.borderColor=[[UIColor blackColor]CGColor];
        cuiDanButton.layer.borderWidth=1;
        
        
        
        return footView;
    }else{
    
        return nil;
    }
    

}


- (IBAction)segChange:(id)sender {
    [self.mTableView reloadData];
}
@end
