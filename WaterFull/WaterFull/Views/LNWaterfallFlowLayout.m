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
// 根据itemWidth大小计算布局属性
-(void)computeAttributesWithItemWidth:(CGFloat)itemWidth {
    
    // 定义一个列高数组，计算每一列的总高度
    CGFloat columnHeight[self.columCount];
//    NSMutableArray *columnHeightArray = [NSMutableArray arrayWithCapacity:self.columCount];
    // 定义一个记录每一列的总item的个数的数组
    NSInteger columnItemCount[self.columCount];
    
    // 初始化
    for (int i =0 ; i<self.columCount; i++) {
//        columnHeightArray[i] = [NSNumber numberWithFloat:self.sectionInset.top];
        columnHeight[i] =self.sectionInset.top;
        columnItemCount[i] =0;
    }
    NSInteger index =0;
    NSMutableArray *attributesArray =[NSMutableArray arrayWithCapacity:self.goodList.count];
    
    // 遍历所有的good模型的数组对象，分别设置其属性
    for (LNGood *good in self.goodList) {
        NSIndexPath *indexPath =[NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        // 计算若干列中最短的列，作为下一个布局的X，Y值
        NSInteger colum =[self shortestColum:columnHeight];
        // 数据追加到最短列
        columnItemCount[colum]++;
        // 计算当前布局对象的各个属性（x，y，H）
        CGFloat itemX =(itemWidth +self.minimumInteritemSpacing) *colum +self.sectionInset.left;
        CGFloat itemY =columnHeight[colum];
        CGFloat itemH =good.h *itemWidth/good.w;
        //设置当前布局对象的属性，并添加到布局数组中
        attributes.frame =CGRectMake(itemX, itemY, itemWidth, itemH);
        [attributesArray addObject:attributes];
        // 把当前列的高度增加
        columnHeight[colum] +=itemH +self.minimumLineSpacing;
        index ++;
    }
    // 计算最长列的高度（目的：为下面的页脚计算和整个collectionView的ContentSize大小计算作准备）
    NSInteger colum =[self highestColum:columnHeight];
    // 计算整个collectionView的ContentSize大小
    CGFloat itemH =(columnHeight[colum] -self.minimumLineSpacing * columnItemCount[colum])/columnItemCount[colum];
    self.itemSize =CGSizeMake(itemWidth, itemH);
    // 设置页脚属性和大小
    NSIndexPath *footerIndexPath =[NSIndexPath indexPathForItem:0 inSection:0];
    UICollectionViewLayoutAttributes *footerAttr =[UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:footerIndexPath];
    footerAttr.frame =CGRectMake(0, columnHeight[colum], self.collectionView.bounds.size.width, 50);
    [attributesArray addObject:footerAttr];
    // 添加的临时属性数组，为下面的返回这个数组布局作准备
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

// 当出现当前的布局对象时，返回当前的以及之前的所有属性数组，（注意：一旦计算完毕，所有的属性会被缓存，不会再被计算）
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutAttributesArray;
}
@end
