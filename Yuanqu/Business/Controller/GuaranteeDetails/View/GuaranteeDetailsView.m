//
//  GuaranteeDetailsView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

//报修详情视图
#import "GuaranteeDetailsView.h"
#import "DemandHeaderView.h"
#import "GuaranteeDetailsHeaderView.h"
#import "GuaranteeListModel.h"
#import "LogModel.h"
#import "LogBaseModel.h"


static NSString * kLogCellID = @"kLogCellID";

@interface GuaranteeDetailsView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) GuaranteeDetailsHeaderView *guaranteeDetailsHeaderView;

@end

@implementation GuaranteeDetailsView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        //弹簧
        self.bounces = NO;
        //代理
        self.dataSource = self;
        self.delegate = self;
        
        //注册
        [self registerClass:[LogCell class] forCellReuseIdentifier:kLogCellID];
        
        //去掉下划线
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        //行高
//        self.rowHeight = 100;
        //去掉滚动轴
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.tableFooterView = [[UIView alloc]init];
        
        [self setupGuaranteeDetailsHeaderView];
    }
    return self;
}

//设置详情头部视图
- (void)setupGuaranteeDetailsHeaderView {

    GuaranteeDetailsHeaderView *guaranteeDetailsHeaderView = [[GuaranteeDetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 230)];
    
    self.tableHeaderView = guaranteeDetailsHeaderView;
    self.guaranteeDetailsHeaderView = guaranteeDetailsHeaderView;
}


- (void)setModel:(GuaranteeListModel *)model {
    
    _model = model;
    self.guaranteeDetailsHeaderView.model = model;
}

#pragma mark --dataSoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    LogBaseModel *model = self.dataArray[section];
    
    return model.content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LogCell *cell = [tableView dequeueReusableCellWithIdentifier:kLogCellID forIndexPath:indexPath];
  
    LogBaseModel *baseModel = self.dataArray[indexPath.section];
    
    LogModel *model = baseModel.content[indexPath.row];
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:kLogCellID cacheByKey:indexPath configuration:^(id cell) {
        LogBaseModel *baseModel = self.dataArray[indexPath.section];
        
        LogModel *model = baseModel.content[indexPath.row];
        
        ((LogCell *)cell).model = model;
    }];
    
}

//设置每个section的headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    DemandHeaderView *headerView = [[DemandHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
    
    //设置标记
    headerView.idx = section;
    //回调
    __weak GuaranteeDetailsView *weakSelf = self;
    headerView.clickFunctionBlock = ^(NSInteger idx) {
        __strong GuaranteeDetailsView *strongSelf = weakSelf;
        switch (idx) {
            case 1:
                if (strongSelf.complaintsBlock) {
                    strongSelf.complaintsBlock();
                }
                break;
            case 2:
                
                break;
            default:
                break;
        }
    };
    
    switch (section) {
        case 0:
            headerView.isHidden = YES;
            headerView.groundColor = [UIColor colorWithHexString:@"#98FB98"];
            headerView.title = @"进度查询";
            headerView.buttonStr = @"";
            break;
        case 1:
            headerView.isHidden = NO;
            headerView.groundColor = [UIColor colorWithHexString:@"#98FB98"];
            headerView.title = @"投诉查询";
            headerView.buttonStr = @"我要投诉";
            break;
        default:
            break;
    }
    
    return headerView;
    
}

//设置每个section的headerView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

//    if (self.isComplaints == NO && section == 1) {
//        return 0;
//    } 
    
    return 44;
}


//是否有数据
- (void)setIsTableData:(BOOL)isTableData {

    _isTableData = isTableData;
    
    if (isTableData == NO) {

        self.dataArray = @[];
        [self reloadData];
        
    }
    
}


#pragma mark --lazy
//- (NSArray *)dataArray {
//
//    if (_dataArray == nil) {
//        _dataArray = @[
//                       @"1",
//                       @"2"
//                       ];
//    }
//    
//    return _dataArray;
//}

@end


@interface LogCell()

@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation LogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {

    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"123";
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    contentLabel.font = [UIFont systemFontOfSize:14];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).mas_offset(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
}


- (void)setModel:(LogModel *)model {

    _model = model;
    self.contentLabel.text = model.NEIRONG;
}

//计算高度
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [self.contentLabel sizeThatFits:size].height;
//    totalHeight += 8 * 2; // margins
    return CGSizeMake(size.width, totalHeight);
}





@end
