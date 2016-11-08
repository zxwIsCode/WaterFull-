//
//  LNCollectionViewController.m
//  WaterFull
//
//  Created by 李保东 on 16/11/7.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "LNCollectionViewController.h"

#import "LNGood.h"
#import "LNWaterfallFlowCell.h"
#import "LNWaterfallFlowFooterView.h"
#import "LNWaterfallFlowLayout.h"

#define kLNWaterfallFlowCell @"kLNWaterfallFlowCell"
#define kLNWaterfallFlowFooterView @"kLNWaterfallFlowFooterView"

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface LNCollectionViewController ()<UICollectionViewDelegate,
UICollectionViewDataSource>
// 当前数据索引
@property(nonatomic,assign) NSInteger index;
// 商品列表总数组
@property(nonatomic,strong)NSMutableArray *goodList;
// 底部加载视图
@property(nonatomic,weak)LNWaterfallFlowFooterView *footerView;
// 瀑布流布局对象
@property(nonatomic,strong)LNWaterfallFlowLayout *waterfallFlowLayout;

//@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;


@property(nonatomic,strong)UICollectionView *collectionView;


@end

@implementation LNCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    [self loadData];
//    self.view.backgroundColor =[UIColor redColor];
//    self.collectionView.backgroundColor =[UIColor blueColor];


    
    // Do any additional setup after loading the view.
}

#pragma mark - Private Methods

-(void)loadData {
    
    NSArray *goods =[LNGood goodsWithIndex:self.index];
    [self.goodList addObjectsFromArray:goods];
    self.index ++;
    // 设置瀑布流数据
    self.waterfallFlowLayout.columCount =3;
    self.waterfallFlowLayout.goodList =self.goodList;
    [self.collectionView reloadData];
}


#pragma mark - Action Methods

#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LNWaterfallFlowCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kLNWaterfallFlowCell forIndexPath:indexPath];
    cell.good = self.goodList[indexPath.item];
    cell.backgroundColor =[UIColor brownColor];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionFooter) {
        self.footerView =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kLNWaterfallFlowFooterView forIndexPath:indexPath];
        return self.footerView;
    }
    return nil;
}
#pragma mark - Setter & Getter

-(NSMutableArray *)goodList {
    if (!_goodList) {
        _goodList =[NSMutableArray array];
    }
    return _goodList;
}
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        self.waterfallFlowLayout =[[LNWaterfallFlowLayout alloc]init];
        
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight) collectionViewLayout:self.waterfallFlowLayout];
        _collectionView.backgroundColor =[UIColor redColor];
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        _collectionView.dataSource =self;
        _collectionView.delegate =self;
        _collectionView.bounces =NO;
        
        //  设置cell
           [_collectionView registerClass:[LNWaterfallFlowCell class] forCellWithReuseIdentifier:kLNWaterfallFlowCell];
        
        //  设置分区的title
        [_collectionView registerClass:[LNWaterfallFlowFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kLNWaterfallFlowFooterView];
    }
    return _collectionView;
}
-(BOOL)prefersStatusBarHidden {
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
