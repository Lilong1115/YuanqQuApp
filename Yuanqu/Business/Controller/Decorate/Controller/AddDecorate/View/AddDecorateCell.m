//
//  AddDecorateCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/7/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "AddDecorateCell.h"
#import "AddDecorateModel.h"
#import "BLDatePickerView.h"

@interface AddDecorateCell()<BLDatePickerViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

//输入内容
@property (nonatomic, weak) UITextField *text;
//标题
@property (nonatomic, weak) UILabel *title;
//添加按钮
@property (nonatomic, weak) UIImageView *addImage;

//时间选择器
@property (nonatomic, strong) BLDatePickerView *pickerView;

//按钮
@property (nonatomic, weak) UIButton *noAgreedButton;
@property (nonatomic, weak) UIButton *agreedButton;
@property (nonatomic, weak) UILabel *noAgreedLabel;
@property (nonatomic, weak) UILabel *agreedLabel;

//选中按钮
@property (nonatomic, strong) UIButton *selectedButton;

//选择器内容
@property (nonatomic, strong) NSArray *chooserArray;

@end

@implementation AddDecorateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {
    
    //内容区
    UITextField *text = [[UITextField alloc]init];
//    text.text = @"123";
    text.layer.borderWidth = 1;
    text.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:text];
    self.text = text;
    text.delegate = self;
    
    UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 10)];
    leftview.backgroundColor = [UIColor whiteColor];
    text.leftView = leftview;
    text.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 10)];
    rightView.backgroundColor = [UIColor whiteColor];
    text.rightView = rightView;
    text.rightViewMode = UITextFieldViewModeAlways;
    
    UILabel *title = [[UILabel alloc]init];
    title.numberOfLines = 0;
    title.text = @"客户名称:";
    title.font = [UIFont systemFontOfSize:15];
    title.textAlignment = NSTextAlignmentCenter;
//    title.layer.borderWidth = 1;
//    title.layer.borderColor = [UIColor grayColor].CGColor;
    title.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:title];
    self.title = title;
    
    UIImageView *addImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addImg"]];
    [self.contentView addSubview:addImage];
    self.addImage = addImage;
    
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:view];
    
    UIButton *agreedButton = [self creatButtonWithTitle:@"同意"];
    [self.contentView addSubview:agreedButton];
    self.agreedButton = agreedButton;
    agreedButton.selected = YES;
    self.selectedButton = agreedButton;
    
    UILabel *agreedLabel = [[UILabel alloc]init];
    agreedLabel.text = @"同意";
    agreedLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:agreedLabel];
    self.agreedLabel = agreedLabel;
    
    UIButton *noAgreedButton = [self creatButtonWithTitle:@"不同意"];
    [self.contentView addSubview:noAgreedButton];
    self.noAgreedButton = noAgreedButton;
    
    UILabel *noAgreedLabel = [[UILabel alloc]init];
    noAgreedLabel.text = @"不同意";
    noAgreedLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:noAgreedLabel];
    self.noAgreedLabel = noAgreedLabel;
    
    //布局
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.top.mas_equalTo(self.contentView).mas_offset(8);
        make.width.mas_equalTo(ScreenW - 8 * 2 - 100);
        make.height.mas_equalTo(40);
    }];
//    [text sizeToFit];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).mas_offset(8);
        make.centerY.mas_equalTo(text);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(text);
    }];
    [addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(text);
        make.height.mas_equalTo(text);
        make.width.mas_equalTo(addImage.mas_height);
    }];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.height.mas_equalTo(text);
//        make.width.mas_equalTo(2);
//        make
//    }];
    
    [agreedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(text);
        make.leading.mas_equalTo(text).mas_offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    [agreedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(text);
        make.leading.mas_equalTo(agreedButton.mas_trailing).mas_offset(8);
    }];
    [noAgreedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(text);
        make.leading.mas_equalTo(agreedLabel.mas_trailing).mas_offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    [noAgreedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(text);
        make.leading.mas_equalTo(noAgreedButton.mas_trailing).mas_offset(8);
    }];
    
}


- (UIButton *)creatButtonWithTitle:(NSString *)title {

    UIButton *button = [[UIButton alloc]init];
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    button.backgroundColor = [UIColor lightGrayColor];
//    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"checkbox_pic_non"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"checkbox_pic"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}



- (void)clickSelectButton:(UIButton *)sender {
    
    self.selectedButton.selected = NO;
    self.selectedButton = sender;
    self.selectedButton.selected = YES;
    
}

- (void)clear {

    self.text.text = @"";
}

- (void)setModel:(AddDecorateModel *)model {

    _model = model;
    self.title.text = model.title;
    switch (model.keyboardType) {
        case DefaultType:
            self.text.keyboardType = UIKeyboardTypeDefault;
            self.addImage.hidden = YES;
            self.agreedButton.hidden = YES;
            self.noAgreedButton.hidden = YES;
            self.agreedLabel.hidden = YES;
            self.noAgreedLabel.hidden = YES;
            break;
        case NumberType:
            self.text.keyboardType = UIKeyboardTypeNumberPad;
            self.addImage.hidden = YES;
            self.agreedButton.hidden = YES;
            self.noAgreedButton.hidden = YES;
            self.agreedLabel.hidden = YES;
            self.noAgreedLabel.hidden = YES;
            break;
        case DateType:
//            self.text.keyboardType = UIKeyboardTypeDefault;
//            self.text.tintColor = [UIColor whiteColor];
            self.addImage.hidden = YES;
            self.agreedButton.hidden = YES;
            self.noAgreedButton.hidden = YES;
            self.agreedLabel.hidden = YES;
            self.noAgreedLabel.hidden = YES;
            break;
        case AccessoryType:
            self.addImage.hidden = NO;
            self.agreedButton.hidden = YES;
            self.noAgreedButton.hidden = YES;
            self.agreedLabel.hidden = YES;
            self.noAgreedLabel.hidden = YES;
            [self setTextHeight];
            break;
        case SelectType:
            self.addImage.hidden = YES;
            self.agreedButton.hidden = NO;
            self.noAgreedButton.hidden = NO;
            self.agreedLabel.hidden = NO;
            self.noAgreedLabel.hidden = NO;
            self.text.inputView = nil;
            self.text.inputAccessoryView = nil;
            break;
        case ChooserType:
            self.addImage.hidden = YES;
            self.agreedButton.hidden = YES;
            self.noAgreedButton.hidden = YES;
            self.agreedLabel.hidden = YES;
            self.noAgreedLabel.hidden = YES;
            self.text.inputView = [self creatPicker];
            self.text.tintColor = [UIColor whiteColor];
            self.text.text = self.chooserArray[0];
            break;
        default:
            break;
    }
}

- (void)setTextHeight {

    
    [self.text mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(100);
    }];
    
}

- (void)setTextHeightNormal {
    
    
    [self.text mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
    }];
    
}


//选择器
- (UIPickerView *)creatPicker {

    UIPickerView *picker = [[UIPickerView alloc]init];
    picker.backgroundColor = [UIColor lightGrayColor];
    picker.delegate = self;
    picker.dataSource = self;
    return picker;
}


#pragma mark --pickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.chooserArray.count;
}


#pragma mark --pickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.chooserArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    self.text.text = self.chooserArray[row];
}



- (void)setListType:(DecorateListType)listType {

    _listType = listType;
    switch (listType) {
        case RenovationListType:
            self.text.userInteractionEnabled = YES;
            break;
        case RenovationSubmittedType:
            self.text.userInteractionEnabled = NO;
            break;
        case DeleteListType:
            self.text.userInteractionEnabled = NO;
            break;
        default:
            break;
    }
}

- (void)setContent:(NSString *)content {

    _content = content;
    self.text.text = content;
    if (_model.keyboardType == AccessoryType) {
        
        self.addImage.hidden = content.length != 0;
    }
    
}

- (void)setImage:(UIImage *)image {

    _image = image;
    self.addImage.image = image;
}

- (NSString *)contentStr {

    if (self.model.keyboardType == SelectType) {
        
        if (self.selectedButton == self.agreedButton) {
            return @"1";
        } else {
            return @"0";
        }
        
    } else {

        return self.text.text;
    }
}

////计算高度
//- (CGSize)sizeThatFits:(CGSize)size {
//    CGFloat totalHeight = 0;
////    totalHeight += [self.text sizeThatFits:size].height;
//    totalHeight += 40 + 8; // margins
//    return CGSizeMake(size.width, totalHeight);
//}


#pragma mark --textDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.model.keyboardType == DateType) {
        self.text.inputView = [[UIView alloc]init];
        self.text.inputAccessoryView = [[UIView alloc]init];
        self.text.tintColor = [UIColor whiteColor];
        [self.pickerView bl_show];
    } else if (self.model.keyboardType == AccessoryType) {
        self.text.inputView = [[UIView alloc]init];
        self.text.inputAccessoryView = [[UIView alloc]init];
        self.text.tintColor = [UIColor whiteColor];
        [self selectFile];
    }
    
}

//选择文件
- (void)selectFile {

    if (self.clickFile) {
        self.clickFile(self.indexPath);
        [self.text endEditing:YES];
    }
    
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
    
    NSLog(@"%ld", idx);
    
    if (idx < 0) {
        
        [ProgressHUD showError:@"时间选择不正确"];
    } else {
        NSString *endStr = [dateFormatter stringFromDate:endDate];
        self.text.text = endStr;
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

- (NSArray *)chooserArray {

    if (_chooserArray == nil) {
        _chooserArray = @[
                          @"白班",
                          @"夜班"
                          ];
    }
    return _chooserArray;
}


@end
