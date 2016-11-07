//
//  LNGood.h
//  WaterFull
//
//  Created by 李保东 on 16/11/7.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNGood : NSObject

@property(nonatomic,assign) NSInteger h;
@property(nonatomic,assign) NSInteger w;
@property(nonatomic,copy) NSString *img;
@property(nonatomic,copy) NSString *price;

+(NSArray *)goodsWithIndex:(NSInteger)index;// 根据索引返回当前刷新的数组
@end
