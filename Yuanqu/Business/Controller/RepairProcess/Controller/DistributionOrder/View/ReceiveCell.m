//
//  ReceiveCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "ReceiveCell.h"
#import "ReceivePersonModel.h"

@interface ReceiveCell()

//选择按钮
@property (nonatomic, weak) UIButton *selectButton;
//姓名
@property (nonatomic, weak) UILabel *nameLabel;
//职务
@property (nonatomic, weak) UILabel *positionLabel;

@end

@implementation ReceiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {

    //选择按钮
    UIButton *selectButton = [[UIButton alloc]init];
    selectButton.layer.borderWidth = 1;
    selectButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:selectButton];
    self.selectButton = selectButton;
    [selectButton setBackgroundImage:[UIImage imageNamed:@"tick_normal"] forState:UIControlStateNormal];
    [selectButton setBackgroundImage:[UIImage imageNamed:@"tick_selected"] forState:UIControlStateSelected];
    
    [selectButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //名字
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"123";
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //职务
    UILabel *positionLabel = [[UILabel alloc]init];
    positionLabel.text = @"123";
    [self.contentView addSubview:positionLabel];
    self.positionLabel = positionLabel;
    
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.top.mas_equalTo(self.contentView).mas_offset(8);
        make.width.mas_equalTo(selectButton.mas_height);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(selectButton.mas_trailing).mas_offset(8);
    }];
    [positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
    }];
}

//选择
- (void)clickSelectButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}


- (BOOL)isSelected {

    return self.selectButton.selected;
}

- (void)setModel:(ReceivePersonModel *)model {

    _model = model;
    self.nameLabel.text = model.name;
    self.positionLabel.text = model.deptName;
}

@end
