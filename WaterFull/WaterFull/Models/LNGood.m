//
//  LNGood.m
//  WaterFull
//
//  Created by 李保东 on 16/11/7.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "LNGood.h"

@implementation LNGood

+(NSArray *)goodsWithIndex:(NSInteger)index {

    NSString *fileName =[NSString stringWithFormat:@"%ld.plist",index%3 +1];
    NSString *path =[[NSBundle mainBundle]pathForResource:fileName ofType:nil];
    NSArray *goodsArray =[NSArray arrayWithContentsOfFile:path];
    NSMutableArray *tempArray =[NSMutableArray arrayWithCapacity:goodsArray.count];
    
    // 便利数组中的字典，返回模型对象
    for (NSDictionary *dic in goodsArray) {
        [tempArray addObject:[self goodWithDic:dic]];
    }
    return [tempArray copy];
}
+(instancetype)goodWithDic:(NSDictionary *)dic {
    id good =[[self alloc]init];
    [good setValuesForKeysWithDictionary:dic];
    return good;
}
@end
