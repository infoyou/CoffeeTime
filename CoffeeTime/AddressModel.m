//
//  AddressModel.m
//  CoffeeTime
//
//  Created by fule on 15/7/14.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
   
    if (self = [super init])
    {
        
        self.addressId = dict[@"addressId"];
        
        self.userName = dict[@"username"];
        
        self.receiverName = dict[@"receiverName"];
        
        self.receiverPhone = dict[@"receiverPhone"];
        
        self.receiverAddress = dict[@"receiverAddress"];
        
        self.isdefault = dict[@"isdefault"];
    }
    
    return self;
    
}

@end
