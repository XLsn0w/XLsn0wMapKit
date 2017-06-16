//
//  AssetCell.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/17.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AssetCellTypePhoto = 0,
    AssetCellTypeLivePhoto,
    AssetCellTypeVideo,
    AssetCellTypeAudio,
}AssetCellType;

@class AssetModel;

@interface AssetCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (nonatomic, strong) AssetModel *model;
@property (nonatomic, copy) void (^didSelectPhotoBlock)(BOOL);
@property (nonatomic, assign) AssetCellType type;

@end


@class AlbumModel;

@interface AlbumCell : UITableViewCell
@property (nonatomic, strong) AlbumModel *model;
@end

