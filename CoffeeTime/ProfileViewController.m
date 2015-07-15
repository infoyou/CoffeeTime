//
//  ProfileViewController.m
//  CoffeeTime
//
//  Created by fule on 15/6/24.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ProfileViewController.h"
#import "CommonWebViewController.h"
#import "AddressListViewController.h"

@interface ProfileViewController () <UIActionSheetDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    
    // Do any additional setup after loading the view from its nib.
    [self.mTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.mTableView setBackgroundColor:COLOR(238, 237, 235)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initTabHeadView];
    
    self.navigationController.navigationBarHidden=YES;
    
    [self showOrHideTabBar:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTabHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 176)];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:headView.frame];
    bgView.image = [UIImage imageNamed:@"icon50.png"];
    [headView addSubview:bgView];
    
    UITableViewCell *tabHeadView = nil;
    
    if ( ![@"" isEqualToString:[AppManager instance].userId] ) {
        
        // 已经登录
        tabHeadView = [[[NSBundle mainBundle] loadNibNamed:@"ProfileVisitorHeadView" owner:self options:nil] lastObject];
        
        tabHeadView.contentView.backgroundColor = [UIColor clearColor];
        
        // Profile
        UIView *profileView =[tabHeadView viewWithTag:110];
        [self addTapGestureRecognizer:profileView];
        
        // 红包
        UIView *bonusView =[tabHeadView viewWithTag:210];
        [self addTapGestureRecognizer:bonusView];
        
        // 积分
        UIView *pointView =[tabHeadView viewWithTag:220];
        [self addTapGestureRecognizer:pointView];
        
        // 地址
        UIView *addressView =[tabHeadView viewWithTag:230];
        [self addTapGestureRecognizer:addressView];
        
        /*
        UIImageView *avator = (UIImageView *)[tabHeadView viewWithTag:10];
        [avator sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:[AppManager instance].userImageUrl] andPlaceholderImage:[UIImage imageNamed:@"placehold.png"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //Nothing.
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //Nothing.
            avator.image = image;
        }];
        
        avator.layer.borderWidth = 2;
        avator.layer.borderColor = HEX_COLOR(@"0xffffff").CGColor;
        avator.layer.cornerRadius = avator.bounds.size.width/2;
        avator.layer.masksToBounds = YES;
        */
        
        UILabel *name = (UILabel *)[tabHeadView viewWithTag:11];
        if(![[AppManager instance].userNickName isEqualToString:@""]) {
            name.text = [AppManager instance].userNickName;
        } else {
            name.text = [AppManager instance].userName;
        }

//        @synthesize userPoint;
//        @synthesize userBonusNum;
//        @synthesize userAddressNum;
        UILabel *phone = (UILabel *)[tabHeadView viewWithTag:12];
        phone.text=[AppManager instance].userName;
        
        UILabel *bonus = (UILabel *)[tabHeadView viewWithTag:13];
        bonus.text=[AppManager instance].userPoint;
        
        UILabel *point = (UILabel *)[tabHeadView viewWithTag:14];
        point.text=[AppManager instance].userBonusNum;
        
        UILabel *address = (UILabel *)[tabHeadView viewWithTag:15];
        address.text=[AppManager instance].userAddressNum;
//        NSString *pointPrefixStr = @"您现在拥有积分 ";
//        int nameLen = [pointPrefixStr length];
//        
//        NSString *pointStr = [AppManager instance].userPoint;
//        int sloganLen = [pointStr length];
//        
//        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", pointPrefixStr, pointStr]];
//        
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont boldSystemFontOfSize:16.f]
//                              range:NSMakeRange(nameLen, sloganLen)];
//        [attributedStr addAttribute:NSForegroundColorAttributeName
//                              value:HEX_COLOR(@"0xfcff00")
//                              range:NSMakeRange(nameLen, sloganLen)];
//        
//        point.attributedText = attributedStr;
        
        
        
    } else {
        
        // 未登录
        tabHeadView = [[[NSBundle mainBundle] loadNibNamed:@"ProfileVisitorHeadView" owner:self options:nil] lastObject];
        
        tabHeadView.contentView.backgroundColor = [UIColor clearColor];
        
        UIButton *btnLogin = (UIButton *)[tabHeadView viewWithTag:10];
        btnLogin.layer.cornerRadius = 2;
        btnLogin.layer.masksToBounds = YES;
        //[btnLogin addTarget:self action:@selector(doLoginOrRegist) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *addressView = (UIView *)[tabHeadView viewWithTag:110];
    UIView *favoriteView = (UIView *)[tabHeadView viewWithTag:111];
    
//    [self addTapGestureRecognizer:addressView];
//    [self addTapGestureRecognizer:favoriteView];
    
    [headView addSubview:tabHeadView.contentView];
    self.mTableView.tableHeaderView = headView;
}


#pragma mark - tableView的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProfileVisitorCellView" owner:nil options:nil]lastObject];
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
                txtLable.text = @"积分商城";
            }
        }
            break;
        
        case 1:
        {
            if (indexPath.row == 0) {
                
                icon.image = [UIImage imageNamed:@"icon_share.png"];
                txtLable.text = @"推荐给好友";
            } else if (indexPath.row == 1) {
                
                icon.image = [UIImage imageNamed:@"icon_feedback.png"];
                txtLable.text = @"意见反馈";
            }
        }
            break;
            
        case 2:
        {
            if (indexPath.row == 0) {
                
                icon.image = [UIImage imageNamed:@"service_tel.png"];
                
                txtLable.text = @"客服电话";
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
