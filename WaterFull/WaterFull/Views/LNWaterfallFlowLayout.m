//
//  LNWaterfallFlowLayout.m
//  WaterFull
//
//  Created by 李保东 on 16/11/7.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "LNWaterfallFlowLayout.h"
#import "LNGood.h"

@interface LNWaterfallFlowLayout ()
// 所有item组成的属性数组
@property(nonatomic,strong) NSArray *layoutAttributesArray;

@end

@implementation LNWaterfallFlowLayout

// 布局准备方法，通常是做布局准备工作 ，itemSize
// UICollectionView 的ContentSize是根据itemSize动态计算出来的
-(void)prepareLayout {
    // 计算每张图片的宽度：（边距和间距通过系统计算，不自己设置）
    CGFloat contenWidth = self.collectionView.bounds.size.width -self.sectionInset.left -self.sectionInset.right;
    CGFloat marginX =self.minimumLineSpacing;
    CGFloat itemWidth =(contenWidth -marginX *(self.columCount -1))/self.columCount;
    
    // 计算布局属性
    [self computeAttributesWithItemWidth:itemWidth];
}
-(void)computeAttributesWithItemWidth:(CGFloat)itemWidth {
    
    CGFloat columnHeight[self.columCount];
    NSInteger columnItemCount[self.columCount];
    
    for (int i =0 ; i<self.columCount; i++) {
        columnHeight[i] =self.sectionInset.top;
        columnItemCount[i] =0;
    }
    NSInteger index =0;
    NSMutableArray *attributesArray =[NSMutableArray arrayWithCapacity:self.goodList.count];
    
    for (LNGood *good in self.goodList) {
        NSIndexPath *indexPath =[NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        NSInteger colum =[self shortestColum:columnHeight];
        
        columnItemCount[colum]++;
        CGFloat itemX =(itemWidth +self.minimumInteritemSpacing) *colum +self.sectionInset.left;
        CGFloat itemY =columnHeight[colum];
        CGFloat itemH =good.h *itemWidth/good.w;
        
        attributes.frame =CGRectMake(itemX, itemY, itemWidth, itemH);
        [attributesArray addObject:attributes];
        
        columnHeight[colum] +=itemH +self.minimumLineSpacing;
        index ++;
    }
    NSInteger colum =[self highestColum:columnHeight];
    
    CGFloat itemH =(columnHeight[colum] -self.minimumLineSpacing * columnItemCount[colum])/columnItemCount[colum];
    self.itemSize =CGSizeMake(itemWidth, itemH);
    
    NSIndexPath *footerIndexPath =[NSIndexPath indexPathForItem:0 inSection:0];
    UICollectionViewLayoutAttributes *footerAttr =[UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:footerIndexPath];
    footerAttr.frame =CGRectMake(0, columnHeight[colum], self.collectionView.bounds.size.width, 50);
    [attributesArray addObject:footerAttr];
    self.layoutAttributesArray =[attributesArray copy];
    
}
// 找出columHeight 中数组最短序列号，追加数据到最短序列好中
-(NSInteger)shortestColum:(CGFloat *)columnHeight {
    
    CGFloat max =CGFLOAT_MAX;
    NSInteger colum =0;
    for (int i =0; i<self.columCount; i ++) {
        if (columnHeight[i] <max) {
            max =columnHeight[i];
            colum =i;
        }
    }
    return colum;
}
// 找出columHeight 数组中最高序列号
-(NSInteger)highestColum:(CGFloat *)columnHeight {
    CGFloat min =0;
    NSInteger colum =0;
    for (int i =0; i<self.columCount; i++) {
        if (columnHeight[i] >min) {
            min =columnHeight[i];
            colum =i;
        }
    }
    return colum;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutAttributesArray;
}
@end
