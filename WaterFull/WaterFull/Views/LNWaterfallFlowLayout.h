//
//  LNWaterfallFlowLayout.h
//  WaterFull
//
//  Created by 李保东 on 16/11/7.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNWaterfallFlowLayout : UICollectionViewFlowLayout

// 总列数
@property(nonatomic,assign)NSInteger columCount;
// 所有商品数组
@property(nonatomic,strong)NSArray *goodList;

@end
