//
//  LeaseDetailsView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/6.
//  Copyright © 2017年 李龙. All rights reserved.
//
//租赁详情
#import "LeaseDetailsView.h"
#import "BLDatePickerView.h"

@interface LeaseDetailsView()<BLDatePickerViewDelegate>

//时间选择器
@property (nonatomic, strong) BLDatePickerView *pickerView;
//时间选择按钮
@property (nonatomic, weak) UIButton *dateButton;

@end

@implementation LeaseDetailsView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
       
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //标题
    UILabel *place = [self creatLabelWithTitle:@"场地:" color:[UIColor blackColor]];
    UILabel *introduction = [self creatLabelWithTitle:@"简介:" color:[UIColor blackColor]];
    UILabel *date = [self creatLabelWithTitle:@"日期:" color:[UIColor blackColor]];
    
    //内容
    UILabel *placeLabel = [self creatLabelWithTitle:@"球场1号" color:[UIColor grayColor]];
    UILabel *introductionLabel = [self creatLabelWithTitle:@"简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介" color:[UIColor grayColor]];
    introductionLabel.numberOfLines = 0;
    
    //时间选择按钮
    UIButton *dateButton = [[UIButton alloc]init];
    [dateButton setTitle:[[NSDate date] creatDateStr] forState:UIControlStateNormal];
    [dateButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:dateButton];
    [dateButton addTarget:self action:@selector(clickDateButton) forControlEvents:UIControlEventTouchUpInside];
    self.dateButton = dateButton;
    
    
    //布局
    [place mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(self).mas_offset(8);
    }];
    [introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(place.mas_bottom).mas_offset(20);
        make.leading.mas_equalTo(place);
    }];
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(introduction);
        make.bottom.mas_equalTo(self).mas_offset(-8);
    }];
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(place);
        make.leading.mas_equalTo(place.mas_trailing).mas_offset(8);
    }];
    [introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introduction);
        make.leading.mas_equalTo(placeLabel);
        make.trailing.mas_equalTo(self).mas_offset(-8);
    }];
    [dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(date);
        make.leading.mas_equalTo(date.mas_trailing).mas_offset(8);
    }];
    
}

//点击时间
- (void)clickDateButton {

    [self.pickerView bl_show];
}

//创建label
- (UILabel *)creatLabelWithTitle:(NSString *)title color:(UIColor *)color {

    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = color;
    [self addSubview:label];
    return label;
}


#pragma mark --pickerViewDelegate
- (void)bl_selectedDateResultWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day {

    NSString *yearStr = [year substringToIndex:year.length - 1];
    NSString *monthStr = [month substringToIndex:month.length - 1];
    NSString *dayStr = [day substringToIndex:day.length - 1];
    
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *endDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr]];
    
    NSInteger idx = [NSDate calcDaysFromBegin:[NSDate date] end:endDate];
    
    if (idx < 0) {
        
    } else {
        [self.dateButton setTitle:[endDate creatDateStr] forState:UIControlStateNormal];
    }
    
    
}

#pragma mark --lazy
- (BLDatePickerView *)pickerView {

    if (_pickerView == nil) {
        _pickerView = [[BLDatePickerView alloc]init];
        _pickerView.topViewBackgroundColor = [UIColor whiteColor];
        _pickerView.cancelButtonColor = [UIColor blackColor];
        _pickerView.sureButtonColor = [UIColor blackColor];
        [_pickerView bl_setUpDefaultDateWithYear:[NSDate getCurrentYear] month:[NSDate getCurrentMonth] day:[NSDate getCurrentDay]];
        _pickerView.pickViewDelegate = self;
    }
    return _pickerView;
}

@end
