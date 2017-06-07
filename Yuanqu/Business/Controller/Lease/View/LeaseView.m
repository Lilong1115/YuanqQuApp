//
//  LeaseView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/6.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "LeaseView.h"

static NSString * const kLeaseCellID = @"kLeaseCellID";

@interface LeaseView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LeaseView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //代理
        self.dataSource = self;
        self.delegate = self;
        //注册
        [self registerClass:[LeaseCell class] forCellReuseIdentifier:kLeaseCellID];
        
        self.rowHeight = 120;
        self.tableFooterView = [[UIView alloc]init];
        
        
        //下拉刷新
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self.mj_header endRefreshing];
        }];
    }
    
    return self;
}


#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LeaseCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeaseCellID forIndexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark --delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.clickCellBlock) {
        self.clickCellBlock(indexPath.row);
    }
    
}

@end

#pragma mark --cell
@interface LeaseCell()

//图片
@property (nonatomic, weak) UIImageView *iconView;
//场地
@property (nonatomic, weak) UILabel *placeLabel;
//是否空闲
@property (nonatomic, weak) UILabel *freeLabel;
@end

@implementation LeaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //图片
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.image = [UIImage imageNamed:@"star_selecte"];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    //场地
    UILabel *place = [[UILabel alloc]init];
    place.text = @"场地:";
    [self.contentView addSubview:place];
    //场地label
    UILabel *placeLabel = [[UILabel alloc]init];
    placeLabel.text = @"足球场1号";
    placeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:placeLabel];
    self.placeLabel = placeLabel;
    
    //是否空闲
    UILabel *freeLabel = [[UILabel alloc]init];
    freeLabel.text = @"空闲";
    freeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:freeLabel];
    self.freeLabel = freeLabel;
    
    //布局
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.contentView).mas_offset(8);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-8);
        make.width.mas_equalTo(iconView.mas_height);
    }];
    [place mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconView);
        make.leading.mas_equalTo(iconView.mas_trailing).mas_offset(8);
    }];
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(place.mas_trailing).mas_offset(8);
        make.centerY.mas_equalTo(place);
    }];
    [freeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

//设置边距
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 8;
    frame.origin.y += 4;
    frame.size.height -= 8;
    frame.size.width -= 16;
    [super setFrame:frame];
}

@end
