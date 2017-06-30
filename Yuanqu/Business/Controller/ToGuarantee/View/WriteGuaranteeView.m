//
//  WriteGuaranteeView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//
//填写报修
#import "WriteGuaranteeView.h"
#import "GuaranteeModel.h"
#import "WriteGuaranteeFooterView.h"

#pragma mark --宏定义
//底部视图高度
#define FooterViewHeight 250

static NSString * const kWriteGuaranteeCellID = @"kWriteGuaranteeCellID";

@interface WriteGuaranteeView()<UITableViewDelegate, UITableViewDataSource>

//cell数据
@property (nonatomic, strong) NSArray *contentArray;

//尾部视图
@property (nonatomic, strong) WriteGuaranteeFooterView *writeGuaranteeFooterView;

@end

@implementation WriteGuaranteeView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        //弹簧
        self.bounces = NO;
        //代理
        self.dataSource = self;
        self.delegate = self;
        
        //注册
        [self registerClass:[WriteGuaranteeCell class] forCellReuseIdentifier:kWriteGuaranteeCellID];
        
        //去掉下划线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        //行高
//        self.rowHeight = 60;
        //去掉滚动轴
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        [self setupFooterView];
    }
    
    return self;
}

//设置底部视图
- (void)setupFooterView {

    WriteGuaranteeFooterView *writeGuaranteeFooterView = [[WriteGuaranteeFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, FooterViewHeight)];
    self.writeGuaranteeFooterView = writeGuaranteeFooterView;
    
    //选取照片回调
    __weak WriteGuaranteeView *weakSelf = self;
    writeGuaranteeFooterView.selectedImageBlock = ^(){
        __strong WriteGuaranteeView *strongSelf = weakSelf;
        if (strongSelf.selectedImageBlock) {
            strongSelf.selectedImageBlock();
        }
    };
    //清除
    writeGuaranteeFooterView.clearBlock = ^(){
        __strong WriteGuaranteeView *strongSelf = weakSelf;
        if (strongSelf.clearBlock) {
            strongSelf.clearBlock();
        }
    };
    //提交
    writeGuaranteeFooterView.uploadBlock = ^(){
        
        __strong WriteGuaranteeView *strongSelf = weakSelf;
        if (strongSelf.uploadBlock) {
            
            NSDictionary *dict = @{
                                   //报修姓名：RD_BXXM
                                   @"RD_BXXM": ((WriteGuaranteeCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).cellStr,
                                   //报修电话：RD_BXDH
                                   @"RD_BXDH": ((WriteGuaranteeCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).cellStr,
                                   //报修标题：RD_BXBT
                                   @"RD_BXBT": ((WriteGuaranteeCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).cellStr,
                                   //报修内容：RD_BXNR
                                   @"RD_BXNR": ((WriteGuaranteeCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]]).cellStr,
                                   //事发坐标：RD_SFZB
                                   @"RD_SFZB": ((WriteGuaranteeCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).cellStr
                                   };
            
            strongSelf.uploadBlock(dict);
        }
    };
    
    self.tableFooterView = writeGuaranteeFooterView;
}

#pragma mark --dataSoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WriteGuaranteeCell *cell = [tableView dequeueReusableCellWithIdentifier:kWriteGuaranteeCellID forIndexPath:indexPath];
    
    cell.guaranteeModel = self.contentArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    GuaranteeModel *guaranteeModel = self.contentArray[indexPath.row];
    
    return guaranteeModel.textType == textTypeFiled ? 60 : 120;
}

//设置图片
- (void)setGuaranteeImage:(UIImage *)guaranteeImage {

    _guaranteeImage = guaranteeImage;
    self.writeGuaranteeFooterView.guaranteeImage = guaranteeImage;
}


- (void)setIsPhoto:(BOOL)isPhoto {

    _isPhoto = isPhoto;
    self.writeGuaranteeFooterView.isPhoto = isPhoto;
    if (isPhoto == NO) {
        self.writeGuaranteeFooterView.frame = CGRectMake(0, 0, ScreenW, 70);
    }
}

//清除数据
- (void)clearData {

    //滚动防止复用
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    for (int i = 0; i < self.contentArray.count; i++) {
        WriteGuaranteeCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell clearData];
    }
    
    [self.writeGuaranteeFooterView clearImg];
    
    //回到底部
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.contentArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
}

#pragma mark --lazy
- (NSArray *)contentArray {

    if (_contentArray == nil) {
        _contentArray = [GuaranteeModel getGuaranteeModelArray];
    }
    return _contentArray;
}

@end


#pragma mark --cell
@interface WriteGuaranteeCell()

//名称
@property (nonatomic, weak) UILabel *contentLabel;
//内容
@property (nonatomic, weak) UITextField *contentText;
//内容View
@property (nonatomic, weak) UITextView *contentTextView;

@end

@implementation WriteGuaranteeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //名称
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"姓名:";
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    //内容
    UITextField *contentText = [[UITextField alloc]init];
    contentText.placeholder = @"请输入";
    contentText.tintColor = [UIColor redColor];
    contentText.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:contentText];
    self.contentText = contentText;
    //圆角,线
    contentText.layer.cornerRadius = 5;
    contentText.layer.masksToBounds = YES;
    contentText.layer.borderWidth = 1;
    contentText.layer.borderColor = [UIColor grayColor].CGColor;
    
    //内容view
    UITextView *contentTextView = [UITextView creatTextViewWithPlaceholder:@"请输入内容"];
    [self.contentView addSubview:contentTextView];
    self.contentTextView = contentTextView;
    //圆角,线
    contentTextView.layer.cornerRadius = 5;
    contentTextView.layer.masksToBounds = YES;
    contentTextView.layer.borderWidth = 1;
    contentTextView.layer.borderColor = [UIColor grayColor].CGColor;
    
    //布局
    [contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.width.mas_equalTo(ScreenW - 100);
        make.height.mas_equalTo(self.contentView).mas_offset( -8 * 2);
    }];
    
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(contentText);
        make.top.mas_equalTo(contentText).mas_offset(4);
        make.height.mas_equalTo(100);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(contentText.mas_leading).mas_offset(-8);
    }];
}

//设置数据
- (void)setGuaranteeModel:(GuaranteeModel *)guaranteeModel {

    _guaranteeModel = guaranteeModel;
    
    self.contentLabel.text = guaranteeModel.name;
    
    self.contentText.placeholder = guaranteeModel.placeholder;
    
    self.contentTextView.hidden = guaranteeModel.textType == textTypeFiled;
    self.contentText.hidden = guaranteeModel.textType != textTypeFiled;
    if (guaranteeModel.keyboardType == 0) {
        self.contentText.keyboardType = UIKeyboardTypeDefault;
    } else if (guaranteeModel.keyboardType == 1) {
    
        self.contentText.keyboardType = UIKeyboardTypeNumberPad;
        //限制手机号字数
        [self.contentText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
}

//限制手机号字数
- (void)textFieldDidChange:(UITextField *)textField {

    if (textField.text.length > 11) {
        textField.text = [textField.text substringToIndex:11];
    }

}

//清除数据
- (void)clearData {

    self.contentText.text = @"";
    self.contentTextView.text = @"";
    
}

//获取cell输入框信息
- (NSString *)cellStr {

    if (self.guaranteeModel.textType == textTypeFiled) {
        return self.contentText.text;
    } else {
        return self.contentTextView.text;
    }
    
}


@end
