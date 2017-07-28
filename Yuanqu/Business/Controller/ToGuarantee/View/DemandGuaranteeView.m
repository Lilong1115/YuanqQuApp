//
//  DemandGuaranteeView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

//查询报修
#import "DemandGuaranteeView.h"
#import "GuaranteeListModel.h"

static NSString * const kDemandGuaranteeCellID = @"kDemandGuaranteeCellID";

@interface DemandGuaranteeView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DemandGuaranteeView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        //弹簧
//        self.bounces = NO;
        //代理
        self.dataSource = self;
        self.delegate = self;
        
        //注册
        [self registerClass:[DemandGuaranteeCell class] forCellReuseIdentifier:kDemandGuaranteeCellID];
        
        //去掉下划线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        //行高
        self.rowHeight = 200;
        //去掉滚动轴
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        //下拉刷新
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            if (self.refreshBlock) {
                self.refreshBlock();
            }
            
            [self.mj_header endRefreshing];
        }];
    }
    
    return self;
}

#pragma mark --dataSoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DemandGuaranteeCell *cell = [tableView dequeueReusableCellWithIdentifier:kDemandGuaranteeCellID forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //点击详情回调
    __weak DemandGuaranteeView *weakSelf = self;
    cell.clickDetailsBlock = ^(){
        __strong DemandGuaranteeView *strongSelf = weakSelf;
        
        //点击详情回调
        if (strongSelf.clickDetailsBlock) {
            strongSelf.clickDetailsBlock(indexPath);
        }
    };
    
    
    return cell;
}


- (void)setDataArray:(NSArray *)dataArray {

    _dataArray = dataArray;
    [self reloadData];
}

@end

@interface DemandGuaranteeCell()

//单号
@property (nonatomic, weak) UILabel *orderNumLabel;
//姓名
@property (nonatomic, weak) UILabel *nameLabel;
//手机
@property (nonatomic, weak) UILabel *phoneLabel;
//标题
@property (nonatomic, weak) UILabel *titleLabel;
//地址
@property (nonatomic, weak) UILabel *addressLabel;
//时间
@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation DemandGuaranteeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //蓝色视图条
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor colorWithHexString:@"#b0def5"];
    [self.contentView addSubview:blueView];
    
    //名称
    UILabel *orderNum = [self creatLabelWithTitle:@"单  号:" titleColor:[UIColor blackColor]];
    UILabel *name = [self creatLabelWithTitle:@"姓  名:" titleColor:[UIColor blackColor]];
    UILabel *phone = [self creatLabelWithTitle:@"手  机:" titleColor:[UIColor blackColor]];
    UILabel *title = [self creatLabelWithTitle:@"标  题:" titleColor:[UIColor blackColor]];
    UILabel *address = [self creatLabelWithTitle:@"地  址:" titleColor:[UIColor blackColor]];
    UILabel *time = [self creatLabelWithTitle:@"时  间:" titleColor:[UIColor blackColor]];
    
    //内容
    UILabel *orderNumLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.orderNumLabel = orderNumLabel;
    UILabel *nameLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.nameLabel = nameLabel;
    UILabel *phoneLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.phoneLabel = phoneLabel;
    UILabel *titleLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.titleLabel = titleLabel;
    UILabel *addressLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.addressLabel = addressLabel;
    UILabel *timeLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    timeLabel.numberOfLines = 0;
    self.timeLabel = timeLabel;
    
    //详情
    UIButton *detailsButton = [[UIButton alloc]init];
    [detailsButton setTitle:@"详情" forState:UIControlStateNormal];
    [detailsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [detailsButton setBackgroundColor:[UIColor colorWithHexString:@"#4491fa"]];
    [self.contentView addSubview:detailsButton];
    [detailsButton addTarget:self action:@selector(clickDetailsButton) forControlEvents:UIControlEventTouchUpInside];
    
    //灰色下划线
    UIView *grayView = [[UIView alloc]init];
    grayView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:grayView];
    
    //布局
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.contentView).mas_offset(8);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.height.mas_equalTo(5);
    }];
    [orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).mas_offset(8);
        make.top.mas_equalTo(blueView.mas_bottom).mas_offset(8);
    }];
    [orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(orderNum);
        make.leading.mas_equalTo(orderNum.mas_trailing).mas_offset(8);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(orderNum);
        make.top.mas_equalTo(orderNum.mas_bottom).mas_offset(8);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(name);
        make.leading.mas_equalTo(name.mas_trailing).mas_offset(8);
    }];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(name);
        make.top.mas_equalTo(name.mas_bottom).mas_offset(8);
    }];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(phone);
        make.leading.mas_equalTo(phone.mas_trailing).mas_offset(8);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(phone);
        make.top.mas_equalTo(phone.mas_bottom).mas_offset(8);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(title);
        make.leading.mas_equalTo(title.mas_trailing).mas_offset(8);
    }];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(title);
        make.top.mas_equalTo(title.mas_bottom).mas_offset(8);
    }];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(address);
        make.leading.mas_equalTo(address.mas_trailing).mas_offset(8);
//        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_centerX).mas_offset(20);
        make.top.mas_equalTo(orderNum);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(time);
        make.leading.mas_equalTo(time.mas_trailing).mas_offset(8);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
    }];
    [detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.top.mas_equalTo(address.mas_bottom).mas_offset(8);
        make.width.mas_equalTo(100);
    }];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.mas_equalTo(detailsButton);
        make.leading.mas_equalTo(self.contentView).mas_offset(8);
        make.height.mas_equalTo(1);
    }];
}

//详情按钮
- (void)clickDetailsButton {

    if (self.clickDetailsBlock != nil) {
        self.clickDetailsBlock();
    }
}

//创建label
- (UILabel *)creatLabelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {

    UILabel *label = [[UILabel alloc]init];
    label.textColor = titleColor;
    label.text = title;
    [self.contentView addSubview:label];
    return label;
}


- (void)setModel:(GuaranteeListModel *)model {
    
    _model = model;
    if (model.itemid) {
        self.orderNumLabel.text = model.itemid;
        self.nameLabel.text = model.rd_BXXM;
        self.phoneLabel.text = model.rd_BXDH;
        self.titleLabel.text = model.rd_BXBT;
        self.addressLabel.text = model.rd_SFZB;
        self.timeLabel.text = model.sysdate;
    } else {
        self.orderNumLabel.text = model.NUMBERS;
        self.nameLabel.text = model.CD_TSXM;
        self.phoneLabel.text = model.CD_LXSJ;
        self.titleLabel.text = model.CD_TSBT;
        self.addressLabel.text = model.CD_LXDZ;
        self.timeLabel.text = model.CJSJ;
    }
    
    
    
}

@end

