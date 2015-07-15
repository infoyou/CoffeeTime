//
//  ShopCarViewController.m
//  CoffeeTime
//
//  Created by fule on 15/6/29.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ShopCarViewController.h"
#import "Header.h"
#import "ShopCarTableViewCell.h"

@interface ShopCarViewController ()<UITextViewDelegate>

@end

@implementation ShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"购物车";
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

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)adjustView
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopCarHeadView" owner:self options:nil];
    UIView *headView = [nib objectAtIndex:0];
    self.mTableView.tableHeaderView = headView;
    
    
    NSArray *nib2 = [[NSBundle mainBundle]loadNibNamed:@"ShopCarFootView" owner:self options:nil];
    UIView *footView = [nib2 objectAtIndex:0];
    UITextView*myTextView=(UITextView*)[footView viewWithTag:10];
    myTextView.returnKeyType=UIReturnKeyDone;
    self.mTableView.tableFooterView=footView;

    
    [self.confirmView setFrame:CGRectMake(self.confirmView.frame.origin.x, self.view.frame.size.height - self.confirmView.frame.size.height-64, SCREEN_WIDTH, self.confirmView.frame.size.height)];
    [self.view bringSubviewToFront:self.confirmView];
    
//    UIButton *btnOK = (UIButton *)[self.confirmView viewWithTag:103];
//    btnOK.layer.cornerRadius = 4;
//    btnOK.layer.masksToBounds = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableView的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellID = @"CellID";
    ShopCarTableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopCarTableViewCell" owner:nil options:nil]lastObject];
        //cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}
//表footView
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//        return 183;
//    
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopCarFootView" owner:self options:nil];
//    UIView *footView = [nib objectAtIndex:0];
//
//    return footView;
//
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}


- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirmButton:(id)sender {
    
    OrderDetailViewController *vc=[OrderDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)xiuGaiButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
   

}

-(void)keyBoardHidden{
    [self.textView resignFirstResponder];

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}
@end
