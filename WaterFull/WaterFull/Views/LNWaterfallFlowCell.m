//
//  LNWaterfallFlowCell.m
//  WaterFull
//
//  Created by 李保东 on 16/11/7.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "LNWaterfallFlowCell.h"
#import "UIImageView+WebCache.h"


#define ScreenHeight [[UIScreen mainScreen] bounds].size.height


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface LNWaterfallFlowCell ()
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *priceLable;
@end

@implementation LNWaterfallFlowCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        if (self) {
            
            self.iconImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)];
            self.priceLable =[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height -20, self.frame.size.width, 20)];
            [self.contentView addSubview:self.iconImageView];
            [self.contentView addSubview:self.priceLable];


        }
    }
    return self;
}

-(void)setGood:(LNGood *)good {

    self.iconImageView.backgroundColor =[UIColor blueColor];
    self.iconImageView.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.width *good.h/good.w);
    self.priceLable.backgroundColor =[UIColor yellowColor];
    NSURL *url = [NSURL URLWithString:good.img];
    [self.iconImageView sd_setImageWithURL:url];

    self.priceLable.text =good.price;
    self.priceLable.textAlignment =NSTextAlignmentCenter;
}

@end
