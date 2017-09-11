//
//  FileManagementView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "FileManagementView.h"
#import "FileManagementModel.h"

@interface FileManagementView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation FileManagementView

static NSString * const kFileManagementCellID = @"kFileManagementCellID";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
       
        self.delegate = self;
        self.dataSource = self;
        
        self.bounces = NO;
//        self.backgroundColor = [UIColor redColor];
        
        [self registerClass:[FileViewCell class] forCellReuseIdentifier:kFileManagementCellID];
        
        self.tableFooterView = [[UIView alloc]init];
        
        
    }
    return self;
}

#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FileViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFileManagementCellID forIndexPath:indexPath];
    
    FileManagementModel *model = self.dataArray[indexPath.row];
    
    cell.indexPath = indexPath;
    cell.model = model;
    __weak FileManagementView *weakSelf = self;
    cell.selectedBlock = ^(NSIndexPath *indexPath) {
        __strong FileManagementView *strongSelf = weakSelf;
        
        if (strongSelf.clickSelectBlock) {
            strongSelf.clickSelectBlock();
        }
        
        if (strongSelf.selectedIndexPath == indexPath) {
            
            FileViewCell *cell = [strongSelf cellForRowAtIndexPath:strongSelf.selectedIndexPath];
            
            [cell noSelected];
            
            strongSelf.selectedIndexPath = nil;
            
            return;
        }
        
        FileViewCell *cell = [strongSelf cellForRowAtIndexPath:strongSelf.selectedIndexPath];
        
        [cell noSelected];
        
        strongSelf.selectedIndexPath = indexPath;
        
    };
    
    return cell;
}


#pragma mark --delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.selecteBlock) {
        self.selecteBlock(indexPath);
    }
}


- (void)setDataArray:(NSArray *)dataArray {

    _dataArray = dataArray;
    [self reloadData];
}


- (FileManagementModel *)selectedModel {

    if (self.selectedIndexPath == nil) {
        return nil;
    }
    
    return self.dataArray[self.selectedIndexPath.row];
}


@end

@interface FileViewCell()

@property (nonatomic, weak) UILabel *content;
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation FileViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    UILabel *content = [[UILabel alloc]init];
    [self.contentView addSubview:content];
    self.content = content;
    
    UIButton *selectButton = [[UIButton alloc]init];
    [selectButton setBackgroundColor:[UIColor grayColor]];
    [selectButton setBackgroundImage:[UIImage imageNamed:@"checkbox_pic_non"] forState:UIControlStateNormal];
    [selectButton setBackgroundImage:[UIImage imageNamed:@"checkbox_pic"] forState:UIControlStateSelected];
    [self.contentView addSubview:selectButton];
    self.selectButton = selectButton;
    [selectButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).mas_offset(8);
    }];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(selectButton.mas_width);
    }];
    
    selectButton.layer.cornerRadius = 15;
    selectButton.layer.masksToBounds = YES;
}

- (void)setModel:(FileManagementModel *)model {

    _model = model;
    self.content.text = model.fileName;
}

- (void)clickSelectButton:(UIButton *)sender {

    sender.selected = !sender.selected;
    
    if (self.selectedBlock) {
        self.selectedBlock(self.indexPath);
    }

    
}

//解除选择
- (void)noSelected {

    self.selectButton.selected = NO;
}

@end


