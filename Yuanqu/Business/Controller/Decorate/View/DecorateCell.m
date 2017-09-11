//
//  DecorateCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/7/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

//装修申报cell
#import "DecorateCell.h"
#import "DecorateModel.h"

@interface DecorateCell()
//申报单位具体内容
@property (nonatomic, weak) UILabel *company;
//申报人员具体内容
@property (nonatomic, weak) UILabel *people;
//申报时间具体内容
@property (nonatomic, weak) UILabel *time;

//审核状态 //1通过 ；2 不通过 ；3审核中
@property (nonatomic, weak) UILabel *auditStatus;
@property (nonatomic, weak) UILabel *auditStatusLabel;

//详情
@property (nonatomic, weak) UIButton *detailsButton;
//提交
@property (nonatomic, weak) UIButton *submitButton;
//删除
@property (nonatomic, weak) UIButton *deleteButton;
//审核
@property (nonatomic, weak) UIButton *auditButton;
//清除
@property (nonatomic, weak) UIButton *clearButton;
//还原
@property (nonatomic, weak) UIButton *reductionButton;

@end

@implementation DecorateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {

    //申报单位具体内容
    UILabel *company = [self creatLabel];
    company.text = @"北京麦斯普工程技术有限公司";
    [self.contentView addSubview:company];
    self.company = company;
    //申报单位
    UILabel *companyLabel = [self creatLabel];
    companyLabel.text = @"申报单位:";
    [self.contentView addSubview:companyLabel];
    
    //申报人员具体内容
    UILabel *people = [self creatLabel];
    people.text = @"123";
    [self.contentView addSubview:people];
    self.people = people;
    //申报单位
    UILabel *peopleLabel = [self creatLabel];
    peopleLabel.text = @"申报人员:";
    [self.contentView addSubview:peopleLabel];
    
    //申报时间具体内容
    UILabel *time = [self creatLabel];
    time.text = @"2017-07-28";
    [self.contentView addSubview:time];
    self.time = time;
    //申报单位
    UILabel *timeLabel = [self creatLabel];
    timeLabel.text = @"申报时间:";
    [self.contentView addSubview:timeLabel];
    
    
    UILabel *auditStatus = [self creatLabel];
    auditStatus.text = @"通过";
    [self.contentView addSubview:auditStatus];
    self.auditStatus = auditStatus;
    
    UILabel *auditStatusLabel = [self creatLabel];
    auditStatusLabel.text = @"审核状态:";
    [self.contentView addSubview:auditStatusLabel];
    self.auditStatusLabel = auditStatusLabel;
    
    //详情
    UIButton *detailsButton = [self creatButtonWithTitle:@"详细" color:[UIColor blueColor]];
    [self.contentView addSubview:detailsButton];
    self.detailsButton = detailsButton;
    [detailsButton addTarget:self action:@selector(clickDetailsButton) forControlEvents:UIControlEventTouchUpInside];
    
    //提交
    UIButton *submitButton = [self creatButtonWithTitle:@"提交" color:[UIColor greenColor]];
    [self.contentView addSubview:submitButton];
    self.submitButton = submitButton;
    [submitButton addTarget:self action:@selector(clickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
    
    //删除
    UIButton *deleteButton = [self creatButtonWithTitle:@"删除" color:[UIColor orangeColor]];
    [self.contentView addSubview:deleteButton];
    self.deleteButton = deleteButton;
    [deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    
    //审核
    UIButton *auditButton = [self creatButtonWithTitle:@"审核" color:[UIColor redColor]];
    [self.contentView addSubview:auditButton];
    self.auditButton = auditButton;
    [auditButton addTarget:self action:@selector(clickAuditButton) forControlEvents:UIControlEventTouchUpInside];
    
    //清除
    UIButton *clearButton = [self creatButtonWithTitle:@"清除" color:[UIColor orangeColor]];
    [self.contentView addSubview:clearButton];
    self.clearButton = clearButton;
    [clearButton addTarget:self action:@selector(clickClearButton) forControlEvents:UIControlEventTouchUpInside];
    
    //还原
    UIButton *reductionButton = [self creatButtonWithTitle:@"还原" color:[UIColor redColor]];
    [self.contentView addSubview:reductionButton];
    self.reductionButton = reductionButton;
    [reductionButton addTarget:self action:@selector(clickReductionButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    //布局
    [company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.top.mas_equalTo(self.contentView).mas_offset(8);
        make.width.mas_equalTo(ScreenW - 8 * 3 - 70);
    }];
    [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(company);
        make.leading.mas_equalTo(self.contentView).mas_equalTo(8);
        make.width.mas_equalTo(70);
    }];

    [people mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.top.mas_equalTo(company.mas_bottom).mas_offset(8);
        make.width.mas_equalTo(company);
    }];
    [peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(people);
        make.leading.mas_equalTo(self.contentView).mas_equalTo(8);
        make.width.mas_equalTo(70);
    }];

    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.top.mas_equalTo(people.mas_bottom).mas_offset(8);
        make.width.mas_equalTo(people);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(time);
        make.leading.mas_equalTo(self.contentView).mas_equalTo(8);
        make.width.mas_equalTo(70);
    }];
    
    [auditStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.top.mas_equalTo(time.mas_bottom).mas_offset(8);
        make.width.mas_equalTo(time);
    }];
    [auditStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(auditStatus);
        make.leading.mas_equalTo(self.contentView).mas_equalTo(8);
        make.width.mas_equalTo(70);
    }];
    
    [detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(20);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(20);
        make.trailing.mas_equalTo(detailsButton.mas_leading).mas_offset(-8);
        make.size.mas_equalTo(detailsButton);
    }];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(20);
        make.trailing.mas_equalTo(submitButton.mas_leading).mas_offset(-8);
        make.size.mas_equalTo(detailsButton);
    }];
    [auditButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(20);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.size.mas_equalTo(detailsButton);
    }];
    [clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(20);
        make.trailing.mas_equalTo(detailsButton.mas_leading).mas_offset(-8);
        make.size.mas_equalTo(detailsButton);
    }];
    [reductionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(20);
        make.leading.mas_equalTo(deleteButton);
        make.size.mas_equalTo(detailsButton);
    }];
    
}

//详情
- (void)clickDetailsButton {

    if (self.clickDetailsBlock) {
        self.clickDetailsBlock(self.indexPath);
    }

}

//删除
- (void)clickDeleteButton {

    if (self.clickDeleteBlock) {
        self.clickDeleteBlock(self.indexPath);
    }
    
}

//提交
- (void)clickSubmitButton {
    if (self.clickSubmitBlock) {
        self.clickSubmitBlock(self.indexPath);
    }
    
}

//审核
- (void)clickAuditButton {
    if (self.clickAuditBlock) {
        self.clickAuditBlock(self.indexPath);
    }
    
}

//清除
- (void)clickClearButton {

    if (self.clickClearBlock) {
        self.clickClearBlock(self.indexPath);
    }
    
}

- (void)clickReductionButton {

    if (self.clickReductionBlock) {
        self.clickReductionBlock(self.indexPath);
    }
    
}


- (UIButton *)creatButtonWithTitle:(NSString *)title color:(UIColor *)color {

    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    return button;
    
}

- (UILabel *)creatLabel {

    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15];
//    label.backgroundColor = RandomColor;
    return label;
    
}


- (void)setModel:(DecorateModel *)model {
    
    _model = model;
    self.company.text = model.dec_KHMC;
    self.people.text = model.dec_KHLX;
    self.time.text = model.sysdate;
    
    if (model.eaasign) {
        
        self.auditStatus.hidden = NO;
        self.auditStatusLabel.hidden = NO;
        
        if ([model.eaasign integerValue] == 1) {
            self.auditStatus.text = @"通过";
        } else if ([model.eaasign integerValue] == 2) {
            self.auditStatus.text = @"不通过";
        } else {
            self.auditStatus.text = @"审核中";
        }
        
    } else {
    
        self.auditStatus.hidden = YES;
        self.auditStatusLabel.hidden = YES;
    }
    
}

- (void)setListType:(DecorateListType)listType {

    _listType = listType;
    switch (listType) {
        case RenovationListType:
            self.auditButton.hidden = YES;
            self.clearButton.hidden = YES;
            self.reductionButton.hidden = YES;
            break;
        case RenovationSubmittedType:
            self.auditButton.hidden = YES;
            self.deleteButton.hidden = YES;
            self.submitButton.hidden = YES;
            self.clearButton.hidden = YES;
            self.reductionButton.hidden = YES;
            break;
        case DeleteListType:
            self.auditButton.hidden = YES;
            self.deleteButton.hidden = YES;
            self.submitButton.hidden = YES;
            break;
        case ToAuditType:
            self.detailsButton.hidden = YES;
            self.submitButton.hidden = YES;
            self.deleteButton.hidden = YES;
            self.clearButton.hidden = YES;
            self.reductionButton.hidden = YES;
            break;
        case AuditedType:
            self.submitButton.hidden = YES;
            self.deleteButton.hidden = YES;
            self.clearButton.hidden = YES;
            self.auditButton.hidden = YES;
            self.reductionButton.hidden = YES;
            break;
        default:
            break;
    }
}


//计算高度
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [self.company sizeThatFits:size].height;
    totalHeight += [self.people sizeThatFits:size].height;
    totalHeight += [self.time sizeThatFits:size].height;
    totalHeight += [self.detailsButton sizeThatFits:size].height;
    totalHeight += (8 * 4 + 20); // margins
    return CGSizeMake(size.width, totalHeight);
}

@end
