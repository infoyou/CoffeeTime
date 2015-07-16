//
//  SettingViewController.m
//  CoffeeTime
//
//  Created by Adam on 15/6/24.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "SettingViewController.h"
#import "CommonWebViewController.h"
#import "AddressListViewController.h"

@interface SettingViewController () <UIActionSheetDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    // Do any additional setup after loading the view from its nib.
    [self.mTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.mTableView setBackgroundColor:COLOR(238, 237, 235)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section == 1){
        
        return 2;
    } else {
        
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellID = @"CellID";
    UITableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SettingCellView" owner:nil options:nil]lastObject];
    }
    
    UIImageView *icon = (UIImageView *)[cell viewWithTag:10];
    UILabel *txtLable = (UILabel *)[cell viewWithTag:11];
    UILabel *txtDescLable = (UILabel *)[cell viewWithTag:12];
    
    if (indexPath.section != 2)
        txtDescLable.hidden = YES;
    else
        txtDescLable.hidden = NO;
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                
                icon.image = [UIImage imageNamed:@"icon_point.png"];
                txtLable.text = @"启动时，自动定位到当前位置";
            }
        }
            break;
        
        case 1:
        {
            if (indexPath.row == 0) {
                
                icon.image = [UIImage imageNamed:@"icon_share.png"];
                txtLable.text = @"关于";
            } else if (indexPath.row == 1) {
                
                icon.image = [UIImage imageNamed:@"icon_feedback.png"];
                txtLable.text = @"商务合作";
            }
        }
            break;
            
        default:
            break;
    }
    
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommonWebViewController *webVC = [[CommonWebViewController alloc] init];
    
    switch (indexPath.section) {
        case 0:
        {
            webVC.strTitle = @"积分商城";
            webVC.strUrl = [NSString stringWithFormat:@"http://www.baidu.com"];

        }
            break;

        case 1:
        {
            if (indexPath.row == 0) {

                webVC.strTitle = @"推荐给好友";
                webVC.strUrl = [NSString stringWithFormat:@"http://www.163.com"];
            } else {
                
                webVC.strTitle = @"意见反馈";
                webVC.strUrl = [NSString stringWithFormat:@"http://www.qq.com"];
            }
            
        }
            break;

        case 2:
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                     delegate:self
                                                            cancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"021-56780893", nil];
            [actionSheet showInView:self.view];
        }
            break;

            
        default:
            break;
    }
    
    [self.navigationController pushViewController:webVC animated:YES];
    
    self.navigationController.navigationBarHidden=NO;
}

#pragma mark - UIActionSheetDelegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"10086"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
}

- (void)imageviewTouchEvents:(UIGestureRecognizer *)gestureRecognizer
{
    UIView *view = (UIView*)[gestureRecognizer view];
    NSInteger viewTag = view.tag;
    
    switch (viewTag) {
            
        case 110:
        {
            [self showHUDWithText:@"账户信息"];
            
            break;
        }
            
        case 210:
        {
            // 红包
            [self showHUDWithText:@"红包"];
            
            break;
        }
            
        case 220:
        {
            // 积分
            CommonWebViewController *webVC = [[CommonWebViewController alloc] init];

            webVC.strTitle = @"我的积分";
            webVC.strUrl = [NSString stringWithFormat:@"http://m.ele.me/gift"];

            [self.navigationController pushViewController:webVC animated:YES];
            
            break;
        }
            
        case 230:
        {
            // 地址
            AddressListViewController *addressVC = [[AddressListViewController alloc] init];
            
            [self.navigationController pushViewController:addressVC animated:YES];
            
            self.navigationController.navigationBarHidden = NO;
            
            break;
        }
            
        default:
            break;
    }
}

- (IBAction)goSettingVC:(id)sender {
    
    [self showHUDWithText:@"设置"];
}

@end
