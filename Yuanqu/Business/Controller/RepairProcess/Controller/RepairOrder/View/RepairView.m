//
//  RepairView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "RepairView.h"
#import "GuaranteeListModel.h"
#import "RepairOrderModel.h"

static NSString * const kDemandGuaranteeCellID = @"kDemandGuaranteeCellID";

@interface RepairView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation RepairView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        //弹簧
        //        self.bounces = NO;
        //代理
        self.dataSource = self;
        self.delegate = self;
        
        //注册
        [self registerClass:[RepairCell class] forCellReuseIdentifier:kDemandGuaranteeCellID];
        
        //去掉下划线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        //行高
//        self.rowHeight = 200;
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
    
    /**
     *  如果没有数据的时候提示用户的信息
     */
    [tableView tableViewDisplayWitMsg:@"暂无数据" ifNecessaryForRowCount:self.dataArray.count];
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RepairCell *cell = [tableView dequeueReusableCellWithIdentifier:kDemandGuaranteeCellID forIndexPath:indexPath];
    
    switch (self.idx) {
        case 0:
            cell.model = self.dataArray[indexPath.row];
            break;
        case 1:
            cell.repairOrderModel = self.dataArray[indexPath.row];
            break;
        default:
            break;
    }

    cell.indexPath = indexPath;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.fd_enforceFrameLayout = YES;
    
    //点击详情回调
    __weak RepairView *weakSelf = self;
    cell.clickDetailsBlock = ^(NSIndexPath *indexPath){
        __strong RepairView *strongSelf = weakSelf;
        
        //点击详情回调
        if (strongSelf.clickDetailsBlock != nil) {
            strongSelf.clickDetailsBlock(indexPath);
        }
    };
    
    
    return cell;
}
//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:kDemandGuaranteeCellID cacheByKey:indexPath configuration:^(id cell) {
        switch (self.idx) {
            case 0:
                ((RepairCell *)cell).model = self.dataArray[indexPath.row];
                break;
            case 1:
                ((RepairCell *)cell).repairOrderModel = self.dataArray[indexPath.row];
                break;
            default:
                break;
        }
    }];
    
}


- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    [self reloadData];
}

@end

@interface RepairCell()

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
//详情
@property (nonatomic, weak) UIButton *detailsButton;

@end

@implementation RepairCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
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
    UILabel *orderNum = [self creatLabelWithTitle:@"报修单号:" titleColor:[UIColor blackColor]];
    UILabel *name = [self creatLabelWithTitle:@"姓        名:" titleColor:[UIColor blackColor]];
    UILabel *phone = [self creatLabelWithTitle:@"手        机:" titleColor:[UIColor blackColor]];
    UILabel *title = [self creatLabelWithTitle:@"标        题:" titleColor:[UIColor blackColor]];
    UILabel *address = [self creatLabelWithTitle:@"地        址:" titleColor:[UIColor blackColor]];
    UILabel *time = [self creatLabelWithTitle:@"时        间:" titleColor:[UIColor blackColor]];
    
    //内容
    UILabel *orderNumLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.orderNumLabel = orderNumLabel;
    UILabel *nameLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.nameLabel = nameLabel;
    UILabel *phoneLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.phoneLabel = phoneLabel;
    UILabel *titleLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    titleLabel.numberOfLines = 0;
    self.titleLabel = titleLabel;
    UILabel *addressLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    addressLabel.numberOfLines = 0;
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
    self.detailsButton = detailsButton;
    
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
        make.top.mas_equalTo(orderNum);
        make.leading.mas_equalTo(orderNum.mas_trailing).mas_offset(8);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(orderNum);
        make.top.mas_equalTo(orderNum.mas_bottom).mas_offset(8);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(name);
        make.leading.mas_equalTo(name.mas_trailing).mas_offset(8);
    }];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(name);
        make.top.mas_equalTo(name.mas_bottom).mas_offset(8);
    }];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phone);
        make.leading.mas_equalTo(phone.mas_trailing).mas_offset(8);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(phone);
        make.top.mas_equalTo(phone.mas_bottom).mas_offset(8);
        make.width.mas_equalTo(phone);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title);
        make.leading.mas_equalTo(title.mas_trailing).mas_offset(8);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
    }];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(title);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(8);
        make.width.mas_equalTo(title);
    }];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(address);
        make.leading.mas_equalTo(address.mas_trailing).mas_offset(8);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
//        make.width.mas_equalTo(ScreenW - address.frame.size.width - 8 * 3);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_centerX).mas_offset(20);
        make.top.mas_equalTo(orderNum);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(time);
        make.leading.mas_equalTo(time.mas_trailing).mas_offset(8);
//        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
    }];
    [detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.top.mas_equalTo(addressLabel.mas_bottom).mas_offset(8);
        make.width.mas_equalTo(100);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-8);
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
        self.clickDetailsBlock(self.indexPath);
    }
}

//创建label
- (UILabel *)creatLabelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = titleColor;
    label.text = title;
    [self.contentView addSubview:label];
    return label;
}


- (void)setModel:(GuaranteeListModel *)model {
    
    _model = model;
    self.orderNumLabel.text = model.itemid;
    self.nameLabel.text = model.rd_BXXM;
    self.phoneLabel.text = model.rd_BXDH;
    self.titleLabel.text = model.rd_BXBT;
    self.addressLabel.text = model.rd_SFZB;
    self.timeLabel.text = model.sysdate;
}

- (void)setRepairOrderModel:(RepairOrderModel *)repairOrderModel {

    _repairOrderModel = repairOrderModel;
    self.orderNumLabel.text = repairOrderModel.itemid;
    self.nameLabel.text = repairOrderModel.wd_KHMC;
    self.phoneLabel.text = repairOrderModel.wd_BXDH;
    self.titleLabel.text = repairOrderModel.wd_BXBT;
    self.addressLabel.text = repairOrderModel.wd_WYDZ;
    self.timeLabel.text = repairOrderModel.sysdate;
    
}


//计算高度
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [self.orderNumLabel sizeThatFits:size].height;
    totalHeight += [self.nameLabel sizeThatFits:size].height;
    totalHeight += [self.phoneLabel sizeThatFits:size].height;
    totalHeight += [self.titleLabel sizeThatFits:size].height;
    totalHeight += [self.addressLabel sizeThatFits:size].height;
    totalHeight += [self.detailsButton sizeThatFits:size].height;
    totalHeight += (8 * 8 + 1 + 5); // margins
    return CGSizeMake(size.width, totalHeight);
}

@end
