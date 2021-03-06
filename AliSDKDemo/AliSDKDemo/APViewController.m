//
//  APViewController.m
//  AliSDKDemo
//
//  Created by 方彬 on 11/29/13.
//  Copyright (c) 2013 Alipay.com. All rights reserved.
//

#import "APViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "APAuthV2Info.h"

@implementation Product


@end

@interface APViewController ()

@end

@implementation APViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self generateData];
}


#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
	static int kNumber = 15;
	
	NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	NSMutableString *resultStr = [[NSMutableString alloc] init];
	srand(time(0));
	for (int i = 0; i < kNumber; i++)
	{
		unsigned index = rand() % [sourceStr length];
		NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
		[resultStr appendString:oneStr];
	}
	return resultStr;
}



#pragma mark -
#pragma mark   ==============产生订单信息==============

- (void)generateData{
	NSArray *subjects = @[@"1",
                          @"2",@"3",@"4",
                          @"5",@"6",@"7",
                          @"8",@"9",@"10"];
	NSArray *body = @[@"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据"];
	
	if (nil == self.productList) {
		self.productList = [[NSMutableArray alloc] init];
	}
	else {
		[self.productList removeAllObjects];
	}
    
	for (int i = 0; i < [subjects count]; ++i) {
		Product *product = [[Product alloc] init];
		product.subject = [subjects objectAtIndex:i];
		product.body = [body objectAtIndex:i];
        
		product.price = 0.01f+pow(10,i-2);
		[self.productList addObject:product];
	}
}


#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55.0f;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.productList count];
}




//
//用TableView呈现测试数据,外部商户不需要考虑
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
													reuseIdentifier:@"Cell"];
    
	Product *product = [self.productList objectAtIndex:indexPath.row];

    cell.textLabel.text = product.body;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"一口价：%.2f",product.price];
	
	return cell;
}


#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
//
//选中商品调用支付宝极简支付
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	/*
	 *点击获取prodcut实例并初始化订单信息
	 */
	Product *product = [self.productList objectAtIndex:indexPath.row];
	
	/*
	 *商户的唯一的parnter和seller。
	 *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
	 */
    
/*============================================================================*/
/*=======================需要填写商户app申请的===================================*/
/*============================================================================*/
//	NSString *partner = @"2088611478824221";
    NSString *partner = @"2088911784783475";
//    NSString *seller = @"cw@aibeigou.com";
//            NSString *seller = @"yuanhx@iyoclub.com.cn/Yotianxia668";
        NSString *seller = @"yuanhx@iyoclub.com.cn";
//    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAL9/Tpy2V/QxMB88A6hjd5IvVlk+5YgA5yE/ifvtR4jlwrKBxh0NlXrrE2KU3HjcFqDDbOQ868uO+7dnvQ49vdpty/cbX3FRG75S5IH+W6ANn7AwkItVkNbYBd82bTHFkvSqWt0Re047KQlsFFyd4axEGGkH1/LvBircZHCvNqrvAgMBAAECgYEAtjeUfShBTxpS+RWpQVzMlWy31Jo13RFG3WtRiEhDbm96sVMtSc34NAtl2cNeex6p5XWvswqJMJwwx1dOHTQA5yc1dzOSN2ttIZrOzqgB4zcsXT5eTpJ2wzEpPTpVBucg7gkLRegaTY14776xZTepM+XnroSt6CJsc1ch0cCLcmECQQDlsM53nVro1KNMuO2kfxBAxyfsv6jlptGEZQyght9dIzTrterS7/7f/B0CyxKWfiKByHxcCxIZgtqZ+WqOvsA/AkEA1W6PnNO078T3/b2fJwJT97i2MsPdAL7wWpfE6cIcDi6L6uRqdzGxO0jqXDgVvuYSHEguNDMgICVaJ467F35pUQJAH6B4zX+dRPICik3savoUAtdpZ+/8EaMmtlQzqObpWqm+X7Zs3x6suaq9U+UiahZ0KeqxNPtRQrIB57GwOneJgQJBAJ3+ZC1RwsUjZ/jb3+6+mG3uvGFEAFvG/KHza38nhCEzb7wILo/hpzMdvO9bTS2tnoZ1IE7f8c4aGGzkCbdQiqECQCXz+1pqMbiHrphdypn+LIMWQGAhIEDRPat5rvz/F8bkw9zBWRanRymMzbW7y0eeeGOdcWxUBLIXiSsl9DkTDME=";
//    NSString *publicKey=@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDax14TuP7Bcs8x5KVqnXTkqjZc831rrUcWRLk2FwNn0+YMrD2MdwEFvUKPdjp2YADep2UZ3jL7u9M1cR2ZDlD8RvlSgHoxGJl3zbBAgBqWRtcV7MFge5FoMMUHO7RJLJlUB40XK0omTNPTiInz9YBk+opHj8KKu5ndCl/CQ5tNqwIDAQAB";
    NSString *privateKey=@"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANrHXhO4/sFyzzHkpWqddOSqNlzzfWutRxZEuTYXA2fT5gysPYx3AQW9Qo92OnZgAN6nZRneMvu70zVxHZkOUPxG+VKAejEYmXfNsECAGpZG1xXswWB7kWgwxQc7tEksmVQHjRcrSiZM09OIifP1gGT6ikePwoq7md0KX8JDm02rAgMBAAECgYEAy/r2jAz/+f3BkRNN54nHYywQY7niRnLYxLputS/fzP6Uj1xIRp7uJRvA42GoQJZiOTZ53RR/FJaa5kkA/6OJfPRS5fFkK6ClBrQKHNKOOSG6xssn4ttNpwBewfJ9bE3HoszCm9oZYJqcS+ztodETBBRuNb+sgDattHlO0W6V5wECQQD1mo43BLR+O3weDEWI9Nm7qlEawWDsfVgg8gyPETDiivcFW0OZsL1wKcNARWgG4rTUlXcS3i7S9BPBwEK4dE1zAkEA5AogtTS+vqEeo7SIsAu+49fvoTSPiHCgQjWCJLI/2+dqIPCzeT6I4xzMEiHC+MjnJsBI43GIEgQOKhvvGQfw6QJBAI7JJQb9eEWvJZB+h+qAlxkQgohwhn3WvWah8gU29Fmwer4led6fLvNHhFkYQMtH/+NbZdeVTlmcRuQsd12vV9sCQAtgzfz8or/UPjkg2ukdzOqFbbl3a+n85KIpFVNLaZBJXaxDFlFoY2AhobUN5jKPo6j1Uy22DnoHpcVIG4f+M3ECQH9F6ZKFbyGoZ/o/I7wLn5pZJY7c0LOw2aeIXlorc53p1QIIIz3uDCBlSaMTy33E3e5g1AdiqyKcUwqMBaAXKks=";
/*============================================================================*/
/*============================================================================*/
/*============================================================================*/
	
	//partner和seller获取失败,提示
	if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
														message:@"缺少partner或者seller或者私钥。"
													   delegate:self
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
		[alert show];
		return;
	}
	
	/*
	 *生成订单信息及签名
	 */
	//将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
	order.partner = partner;
	order.seller = seller;
	order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
	order.productName = product.subject; //商品标题
	order.productDescription = product.body; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
	order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
	
	//应用注册scheme,在AlixPayDemo-Info.plist定义URL types
	NSString *appScheme = @"alisdkdemo";
	
	//将商品信息拼接成字符串
	NSString *orderSpec = [order description];
	NSLog(@"＝＝＝》》orderSpec = %@",orderSpec);
	
	//获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
	id<DataSigner> signer = CreateRSADataSigner(privateKey);
	NSString *signedString = [signer signString:orderSpec];
	
	//将签名成功字符串格式化为订单字符串,请严格按照该格式
	NSString *orderString = nil;
	if (signedString != nil) {
		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"11reslut = %@",resultDic);
            NSLog(@"memo=%@",[resultDic valueForKey:@"memo"]);
        }];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
@end
