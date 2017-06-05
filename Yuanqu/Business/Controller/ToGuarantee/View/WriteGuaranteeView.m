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


- (void)setGuaranteeImage:(UIImage *)guaranteeImage {

    _guaranteeImage = guaranteeImage;
    self.writeGuaranteeFooterView.guaranteeImage = guaranteeImage;
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
    
}

@end
