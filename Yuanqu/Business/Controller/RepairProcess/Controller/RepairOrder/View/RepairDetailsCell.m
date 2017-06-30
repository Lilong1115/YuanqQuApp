//
//  RepairDetailsCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "RepairDetailsCell.h"
#import "RepairTitleModel.h"

@interface RepairDetailsCell()<UIPickerViewDataSource,UIPickerViewDelegate>

//标题
@property (nonatomic, weak) UILabel *titLabel;
//内容
@property (nonatomic, weak) UILabel *contentLabel;
//紧急程度
@property (nonatomic, weak) UITextField *textField;

//picker内容
@property (nonatomic, strong) NSArray *pickerData;

@end

@implementation RepairDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //标题
    UILabel *titLabel = [[UILabel alloc]init];
    titLabel.text = @"编号:";
    [self.contentView addSubview:titLabel];
    self.titLabel = titLabel;
    
    UIView *boxView = [[UIView alloc]init];
    boxView.layer.borderWidth = 1;
    boxView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:boxView];
    
    //内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0;
    contentLabel.text = @"测试";
//    contentLabel.layer.borderColor = [UIColor grayColor].CGColor;
//    contentLabel.layer.borderWidth = 1;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    //紧急程度
    UITextField *textField = [[UITextField alloc]init];
//    textField.layer.borderColor = [UIColor grayColor].CGColor;
//    textField.layer.borderWidth = 1;
    textField.text = @"一般";
    [self.contentView addSubview:textField];
    self.textField = textField;
    textField.tintColor = [UIColor whiteColor];
    
    //选择器
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    textField.inputView = pickerView;

    //布局
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8 * 2);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(ScreenW - 100 - 8);
    }];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8 * 2);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(ScreenW - 100 - 8);
    }];
    [titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(contentLabel.mas_leading).mas_offset(-8);
        make.top.mas_equalTo(contentLabel);
    }];
    [boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(contentLabel).mas_offset(-8);
        make.bottom.trailing.mas_equalTo(contentLabel).mas_offset(8);
    }];
 
    
}


#pragma mark --dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return self.pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return self.pickerData[row];
}

#pragma mark --delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {


    self.textField.text = self.pickerData[row];
}

//设置标题
- (void)setTitleModel:(RepairTitleModel *)titleModel {

    _titleModel = titleModel;
    self.titLabel.text = titleModel.title;
    if (self.isHidden == YES) {
        self.contentLabel.hidden = NO;
        self.textField.hidden = YES;
    } else {
        self.contentLabel.hidden = [titleModel.title isEqualToString:@"紧急程度:"];
        self.textField.hidden = ![titleModel.title isEqualToString:@"紧急程度:"];
    }
    
}

- (void)setContent:(NSString *)content {

    _content = content;
    self.contentLabel.text = content;
}

- (NSString *)degreeStr {

    return self.textField.text;
}


//计算高度
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [self.contentLabel sizeThatFits:size].height;
    
    totalHeight += 8 + 8 + 8 + 8; // margins
    return CGSizeMake(size.width, totalHeight);
}


#pragma mark --lazy
- (NSArray *)pickerData {

    if (_pickerData == nil) {
        
        _pickerData = @[@"一般", @"紧急", @"非常急"];
    }
    
    return _pickerData;
}

@end
