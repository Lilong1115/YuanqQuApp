//
//  SearchBar.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/6.
//  Copyright © 2017年 李龙. All rights reserved.
//
//搜索头部视图
#import "SearchBar.h"

#pragma mark --宏定义
//宽高
#define SearchButtonWidth 70
#define SearchButtonHeight 28

@interface SearchBar()<UIPickerViewDelegate, UIPickerViewDataSource>

//选择数组
@property (nonatomic, copy) NSArray *dataArray;
//选择框
@property (nonatomic, weak) UITextField *selectText;

@end

@implementation SearchBar

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //选项框
    UITextField *selectText = [[UITextField alloc]init];
    selectText.text = @"会场";
    selectText.tintColor = [UIColor whiteColor];
    selectText.font = [UIFont systemFontOfSize:14];
    selectText.layer.cornerRadius = 5;
    selectText.layer.masksToBounds = YES;
    selectText.textAlignment = NSTextAlignmentCenter;
    selectText.backgroundColor = [UIColor whiteColor];
    
    //自定义键盘选择器
    UIPickerView *picker = [[UIPickerView alloc] init];
    
    picker.delegate = self;
    picker.dataSource = self;
    //选择指示器
    [picker setShowsSelectionIndicator:YES];
    selectText.inputView = picker;
    
    UIImageView *selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    selectImage.image = [UIImage imageNamed:@"huisan"];
    selectText.rightView = selectImage;
    selectText.rightViewMode = UITextFieldViewModeAlways;
    //搜索栏
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
    //去掉下划线
    searchBar.backgroundImage = [UIImage imageWithColor:[UIColor groupTableViewBackgroundColor]];
    searchBar.placeholder = @"请输入关键字搜索";
    [self addSubview:searchBar];
    [self addSubview:selectText];
    self.selectText = selectText;
    
    //布局
    [selectText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(self).mas_offset(8);
        make.height.mas_equalTo(SearchButtonHeight);
        make.width.mas_equalTo(SearchButtonWidth);
    }];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(selectText.mas_trailing).mas_offset(-16);
        make.trailing.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];

    
}


#pragma mark - UIPickerViewDelegate 和 UIPickerViewDataSource
//必须实现
// returns the number of 'columns' to display. ->选择器一共有多少列!
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component.. -> 选择器每列有多少行!
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

//选择器每行名称
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.dataArray[row];
    
}


//选择
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selectText.text = self.dataArray[row];
}


#pragma mark --lazy
- (NSArray *)dataArray {

    if (_dataArray == nil) {
        _dataArray = @[
                       @"会场",
                       @"会议室",
                       @"球场"
                       ];
    }
    
    return _dataArray;
}


@end
