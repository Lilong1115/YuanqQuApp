//
//  FileManagementCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "FileManagementCell.h"

@implementation FileManagementCell

//- (instancetype)initWithFrame:(CGRect)frame {
//
//    if (self = [super initWithFrame:frame]) {
//        
//        [self setupUI];
//    }
//    
//    return self;
//}

- (void)setContent:(UIView *)content {

    _content = content;
    [self.contentView addSubview:content];
//    [content mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.contentView);
//    }];
}

@end
