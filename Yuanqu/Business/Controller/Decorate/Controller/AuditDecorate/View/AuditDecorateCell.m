//
//  AuditDecorateCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/7.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "AuditDecorateCell.h"
#import "AuditModel.h"

@interface AuditDecorateCell()

@property (nonatomic, weak) UILabel *opinionLabel;
@property (nonatomic, weak) UILabel *opinion;
@property (nonatomic, weak) UILabel *according;
@property (nonatomic, weak) UILabel *department;
@property (nonatomic, weak) UILabel *time;
@property (nonatomic, weak) UILabel *personnel;

@end

@implementation AuditDecorateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {

    UILabel *opinionLabel = [[UILabel alloc]init];
    opinionLabel.text = @"客户服务部审核意见:";
    opinionLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:opinionLabel];
    self.opinionLabel = opinionLabel;
    
    UILabel *opinion = [[UILabel alloc]init];
    opinion.text = @"通过";
    opinion.textColor = [UIColor colorWithHexString:@"#4491fa"];
    [self.contentView addSubview:opinion];
    self.opinion = opinion;
    
    UILabel *according = [[UILabel alloc]init];
    according.text = @"客户服务部审核意见客户服务部审核意见客户服务部审核意见客户服务部审核意见客户服务部审核意见客户服务部审核意见客户服务部审核意见";
    according.numberOfLines = 0;
    according.textColor = [UIColor lightGrayColor];
    according.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:according];
    self.according = according;
    
    UILabel *accordingLabel = [[UILabel alloc]init];
    accordingLabel.text = @"审核依据:";
    accordingLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:accordingLabel];
    
    UILabel *departmentLabel = [[UILabel alloc]init];
    departmentLabel.text = @"审核部门:";
    departmentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:departmentLabel];
    
    UILabel *department = [[UILabel alloc]init];
    department.font = [UIFont systemFontOfSize:14];
    department.text = @"客户服务部";
    department.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:department];
    self.department = department;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.text = @"审核时间:";
    [self.contentView addSubview:timeLabel];
    
    UILabel *time = [[UILabel alloc]init];
    time.font = [UIFont systemFontOfSize:14];
    time.textColor = [UIColor lightGrayColor];
    time.text = @"2017-07-31";
    [self.contentView addSubview:time];
    self.time = time;
    
    UILabel *personnelLabel = [[UILabel alloc]init];
    personnelLabel.font = [UIFont systemFontOfSize:14];
    personnelLabel.text = @"审核人员:";
    [self.contentView addSubview:personnelLabel];
    
    UILabel *personnel = [[UILabel alloc]init];
    personnel.font = [UIFont systemFontOfSize:14];
    personnel.text = @"张三";
    personnel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:personnel];
    self.personnel = personnel;
    
    [opinionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(self.contentView).mas_offset(8);
    }];
    [opinion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(opinionLabel.mas_trailing).mas_offset(8);
        make.centerY.mas_equalTo(opinionLabel);
    }];
    [according mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(opinion.mas_bottom).mas_offset(8);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.width.mas_equalTo(ScreenW - 90);
    }];
    [accordingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).mas_offset(8);
        make.top.mas_equalTo(opinion.mas_bottom).mas_offset(8);
    }];
    [departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).mas_offset(8);
        make.top.mas_equalTo(according.mas_bottom).mas_offset(8);
    }];
    [department mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(departmentLabel.mas_trailing).mas_offset(8);
        make.centerY.mas_equalTo(departmentLabel);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(department.mas_bottom).mas_offset(8);
        make.leading.mas_equalTo(departmentLabel);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(timeLabel);
        make.leading.mas_equalTo(timeLabel.mas_trailing).mas_offset(8);
    }];
    [personnelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(timeLabel);
        make.top.mas_equalTo(time.mas_bottom).mas_offset(8);
    }];
    [personnel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(personnelLabel);
        make.leading.mas_equalTo(personnelLabel.mas_trailing).mas_offset(8);
    }];
}


- (void)setModel:(AuditModel *)model {

    _model = model;
    self.opinionLabel.text = [NSString stringWithFormat:@"%@审核意见", model.app_SHBM];
    if ([model.app_SHJG integerValue] == 0) {
        self.opinion.text = @"不通过";
        self.opinion.textColor = [UIColor redColor];
    } else {
        self.opinion.text = @"通过";
        self.opinion.textColor = [UIColor colorWithHexString:@"#4491fa"];
    }
    self.according.text = model.app_SHYJ;
    self.department.text = model.app_SHBM;
    self.time.text = model.app_SHSJ;
    self.personnel.text = model.app_SHRY;
 
}


//计算高度
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [self.opinion sizeThatFits:size].height;
    totalHeight += [self.according sizeThatFits:size].height;
    totalHeight += [self.department sizeThatFits:size].height;
    totalHeight += [self.time sizeThatFits:size].height;
    totalHeight += [self.personnel sizeThatFits:size].height;
    totalHeight += 8 * 6 + 10; // margins
    return CGSizeMake(size.width, totalHeight);
}



@end
