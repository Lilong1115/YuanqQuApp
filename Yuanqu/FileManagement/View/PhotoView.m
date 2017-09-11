//
//  PhotoView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PhotoView.h"
#import "PhotoFileCell.h"

@interface PhotoView()<UITableViewDelegate, UITableViewDataSource>


@end


static NSString * const kPhotoCellID = @"kPhotoCellID";
@implementation PhotoView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        self.rowHeight = 80;
        [self registerClass:[PhotoFileCell class] forCellReuseIdentifier:kPhotoCellID];
        
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PhotoFileCell *cell = [tableView dequeueReusableCellWithIdentifier:kPhotoCellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    PHAssetCollection *model = self.dataArray[indexPath.row];
    cell.assetCollection = model;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.selecteBlock) {
        self.selecteBlock(indexPath);
    }
}

- (void)setDataArray:(PHFetchResult *)dataArray {

    _dataArray = dataArray;
    [self reloadData];
}




@end
