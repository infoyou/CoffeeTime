//
//  ShopCartViewController.m
//  CoffeeTime
//
//  Created by Adam on 15/6/29.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ShopCartViewController.h"
#import "Header.h"
#import "ShopCartTableCell.h"

@interface ShopCartViewController () <UITextViewDelegate, ShopCartTableCellDelegate>
{
    NSMutableArray *shopCartDataArray;
    NSInteger currentProductClickTag;
}

@end

@implementation ShopCartViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"购物车";
    
    [self loadShopCartProduct];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //注册通知,监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardDidShowNotification
                                              object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidHidden:)
                                                name:UIKeyboardDidHideNotification
                                              object:nil];
    [super viewWillAppear:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initData
{
    
    shopCartDataArray = [NSMutableArray array];
}

- (void)adjustView
{
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopCartHeadView" owner:self options:nil];
    UIView *headView = [nib objectAtIndex:0];
    self.mTableView.tableHeaderView = headView;
    
    /*
     隐藏foot
     NSArray *nib2 = [[NSBundle mainBundle]loadNibNamed:@"ShopCartFootView" owner:self options:nil];
     UIView *footView = [nib2 objectAtIndex:0];
     UITextView*myTextView=(UITextView*)[footView viewWithTag:10];
     myTextView.returnKeyType=UIReturnKeyDone;
     self.mTableView.tableFooterView=footView;
     */
    
    // Confim view
    [self.confirmView setFrame:CGRectMake(self.confirmView.frame.origin.x, self.view.frame.size.height - self.confirmView.frame.size.height-64, SCREEN_WIDTH, self.confirmView.frame.size.height)];
    
    // Switch
    self.btnSwitchProduct.layer.cornerRadius = 4;
    self.btnSwitchProduct.layer.masksToBounds = YES;
    
    // Confim
    self.btnConfim.layer.cornerRadius = 4;
    self.btnConfim.layer.masksToBounds = YES;
    
    [self.view bringSubviewToFront:self.confirmView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shopCartDataArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"ShopCartCellID";
    ShopCartTableCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopCartTableCell" owner:nil options:nil] lastObject];
        cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ShopCartModel *shopCartModel = shopCartDataArray[indexPath.row];
    
    [cell addProductUnit:shopCartModel indexPath:indexPath];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
    
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)keyBoardHidden{
    
    [self.textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - load ShopCart Product
- (void)loadShopCartProduct
{
    NSMutableArray *shopCartArray = [[FMDBConnection instance] getStoreAllCartFromDB:[AppManager instance].selStoreId];
    
    NSInteger shopCartNum = [shopCartArray count];
    for (NSInteger shopCartIndex = 0; shopCartIndex < shopCartNum; shopCartIndex++) {
        
        ShopCartModel *shopCartModel = shopCartArray[shopCartIndex];
        
        [shopCartDataArray addObject:shopCartModel];
    }
    
    [self showShopCartNumber];
}

#pragma mark - key board option
//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    
    [UIView beginAnimations:nil context:nil];
    
    //定义动画时间
    [UIView setAnimationDuration:0.2];
    
    //设置view的frame，往上平移
    [self.view setFrame:CGRectMake(0, -56, self.view.frame.size.width, self.view.frame.size.height)];
    
    [UIView commitAnimations];
    
    //self.mTableView.contentInset=UIEdgeInsetsMake(0, 0,keyboardRect.size.height, 0);
}

- (void)handleKeyboardDidHidden:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    [UIView beginAnimations:nil context:nil];
    //定义动画时间
    [UIView setAnimationDuration:0.02];
    [self.view setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    
    [UIView commitAnimations];
}

- (IBAction)doConfim:(id)sender {
    
    OrderDetailViewController *vc = [OrderDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)doSwitchProduct:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 实现加减按钮点击代理事件
/**
 *  实现加减按钮点击代理事件
 *
 *  @param cell 当前单元格
 *  @param flag 按钮标识
 */
- (void)btnClick:(UITableViewCell *)cell tag:(NSInteger)tag
{
    
    currentProductClickTag = tag;
    
    [self handleShopCart:currentProductClickTag];
}

- (void)handleShopCart:(NSInteger)tag
{
    int rowIndex = tag / 10000;
    
    int yushu = tag % 10000;
    int goodsTypeListIndex = (yushu - 10) / 10;
    
    if (yushu % 10 == 0) {
        // -
        [self doHandleMethod:1 rowIndex:rowIndex goodsTypeListIndex:goodsTypeListIndex];
    } else if(yushu % 10 == 1) {
        // +
        [self doHandleMethod:2 rowIndex:rowIndex goodsTypeListIndex:goodsTypeListIndex];
    }
    
}

- (void)doHandleMethod:(NSInteger)handleType rowIndex:(NSInteger)rowIndex goodsTypeListIndex:(NSInteger)goodsTypeListIndex
{
    
    ShopCartModel *shopCartModel = (ShopCartModel *)shopCartDataArray[rowIndex];
    
    NSInteger currentShopCartNum = [shopCartModel.shopCartNum integerValue];
    
    if (handleType == 1) {
        
        //做减法
        //先获取到当期行数据源内容，改变数据源内容，刷新表格
        if (currentShopCartNum > 0)
        {
            currentShopCartNum--;
        }
        
    } else if (handleType == 2) {
        
        //做加法
        currentShopCartNum++;
    }
    
    shopCartModel.shopCartNum = @(currentShopCartNum);
    
    [[FMDBConnection instance] updateShopCartLogic:shopCartModel];
    
    [self showShopCartNumber];
    
    //刷新表格
    [self.mTableView reloadData];
    
}

#pragma mark - show shopCart Number
- (void)showShopCartNumber
{
    NSMutableArray *shopCartShowNumber = [[FMDBConnection instance] getShopCartShowNumber:[AppManager instance].selStoreId];
    if ([shopCartShowNumber count] > 0) {
        
        self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%@", shopCartShowNumber[1]];
    } else {
        
        self.totalPriceLabel.text = @"￥0";
    }
}

@end
