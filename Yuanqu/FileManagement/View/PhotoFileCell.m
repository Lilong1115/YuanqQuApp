//
//  PhotoFileCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PhotoFileCell.h"
#import "PhotoManagement.h"

@interface PhotoFileCell()

@property (nonatomic, weak) UIImageView *photoView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, copy) NSString *notificationID;

@end

@implementation PhotoFileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {

    UIImageView *photoView = [[UIImageView alloc]init];
    [self.contentView addSubview:photoView];
    self.photoView = photoView;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(self.contentView).mas_offset(8);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-8);
        make.width.mas_equalTo(photoView.mas_height);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(photoView.mas_trailing).mas_equalTo(8);
    }];
    
}

- (void)setAssetCollection:(PHAssetCollection *)assetCollection {

    _assetCollection = assetCollection;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@  (%ld)", assetCollection.localizedTitle, [PhotoManagement getThumbnailImagesWithPhotoFile:assetCollection].count];
    
    if ([PhotoManagement getThumbnailImagesWithPhotoFile:assetCollection].count != 0) {
        
        self.notificationID = [PhotoManagement getPHAssetArrayWithAsset:[PhotoManagement getThumbnailImagesWithPhotoFile:assetCollection].lastObject original:NO];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setImageNoti:) name:self.notificationID object:nil];
        
    } else {
        self.photoView.image = [UIImage imageNamed:@"icon_pic_break"];
    }
  
}

- (void)setImageNoti:(NSNotification *)noti {

    self.photoView.image = noti.object;
}


//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
