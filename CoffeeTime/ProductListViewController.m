//
//  ProductListViewController.m
//  CoffeeTime
//
//  Created by fule on 15/6/25.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductTableViewCell.h"
#import "Header.h"
#import "GoodsList.h"
#import "GoodsModel.h"

@interface ProductListViewController ()<shangPinTableViewCellDelegate>
{
    NSMutableArray *infoArr;
    
    GoodsList *goodsList;
}

@end

@implementation ProductListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"星巴克";
    
    self.navView.backgroundColor = barColor;
    
    [self loadTestData];
    
}

- (void)adjustView
{
    
    [self.confirmView setFrame:CGRectMake(self.confirmView.frame.origin.x, self.view.frame.size.height - self.confirmView.frame.size.height-64, SCREEN_WIDTH, self.confirmView.frame.size.height)];
    
    self.numLabel.layer.cornerRadius = self.numLabel.frame.size.height/2;
    self.numLabel.layer.masksToBounds = YES;
    
    UIButton *btnOK = (UIButton *)[self.confirmView viewWithTag:103];
    btnOK.layer.cornerRadius = 4;
    btnOK.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTestData
{
    infoArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<10; i++){
        
        // product type list
        NSMutableArray *sharpArray=[NSMutableArray array];
        
        NSArray *array=[NSArray arrayWithObjects:@"大杯",@"中杯",@"小杯", nil];
        
        for (int m=0; m<3; m++) {
            
            NSMutableDictionary*goodsSharpList = [NSMutableDictionary dictionary];
            [goodsSharpList setValue:array[m] forKey:@"goodsSharp"];
            [goodsSharpList setValue:@"￥25" forKey:@"goodsPrice"];
            [goodsSharpList setValue:[NSNumber numberWithInt:0] forKey:@"goodsNum"];
            
            goodsList = [[GoodsList alloc] initWithDict:goodsSharpList];
            [sharpArray addObject:goodsList];
        }
        
        // product list
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        [infoDict setValue:@"冰激凌" forKey:@"goodsTitle"];
        [infoDict setValue:sharpArray forKey:@"goodsArray"];
        
        GoodsModel *goodsModel = [[GoodsModel alloc] initWithDict:infoDict];
        [infoArr addObject:goodsModel];
    }
}

#pragma mark - tableView的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"CellID";
    ProductTableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductTableViewCell" owner:nil options:nil]lastObject];
        cell.delegate = self;
        
    }
    
    GoodsModel*dic=infoArr[indexPath.row];
    //for (int i=0; i<dic.goodsArray.count; i++) {
    
    [cell addTheValue:dic theValue:nil indexPath:indexPath];
    
    //}
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // refeash table
    [self.mTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)jieSuan:(id)sender {
    
    ShopCarViewController*vc = [ShopCarViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
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
    
    // 10000*indexPath.row + (goodsTypeListIndex * 10 + 10);
    
    int rowIndex = flag / 10000;
    
    //  第一行
    int yushu = flag % 10000;
    int goodsTypeListIndex = (yushu - 10) / 10;
    
    // row 1.1
    if (yushu % 10 == 0) {
        // -
        [self doHandleMethod:1 rowIndex:rowIndex goodsTypeListIndex:goodsTypeListIndex];
    } else if(yushu % 10 == 1) {
        // +
        [self doHandleMethod:2 rowIndex:rowIndex goodsTypeListIndex:goodsTypeListIndex];
    }
    
    //刷新表格
    [self.mTableView reloadData];
    
}

- (void)doHandleMethod:(NSInteger)handleType rowIndex:(NSInteger)rowIndex goodsTypeListIndex:(NSInteger)goodsTypeListIndex
{
    if (handleType == 1) {
        
        //做减法
        //先获取到当期行数据源内容，改变数据源内容，刷新表格
        GoodsModel *model = infoArr[rowIndex];
        GoodsList *goodList = model.goodsArray[goodsTypeListIndex];
        
        if (goodList.goodsNum > 0)
        {
            goodList.goodsNum --;
        }
        
    } else if (handleType == 2) {
        
        //做加法
        GoodsModel *model = infoArr[rowIndex];
        GoodsList *goodList=model.goodsArray[goodsTypeListIndex];
        goodList.goodsNum ++;
        
    }
}

@end
