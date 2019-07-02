//
//  HTViewController.m
//  HTImagePickerKit
//
//  Created by zhanglianjiang on 06/26/2019.
//  Copyright (c) 2019 zhanglianjiang. All rights reserved.
//

#import "HTViewController.h"

#import <TZImagePickerController/TZImagePickerController.h>
#import <HTImagePickerKit/HTImageDragView.h>

@interface HTViewController ()<HTImageDragViewDelegate,TZImagePickerControllerDelegate>
{
    
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
}


@property(nonatomic,weak)HTImageDragView *dragView;



@end

@implementation HTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    HTImageDragView *dragView = [[HTImageDragView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
    //上下左右的间距
    dragView.kMarginLRTB = 5;
    //图片之间的间距
    dragView.kMarginB = 5;
    //最大图片数量
    dragView.kMaxCount = 9;
    //每行的图片数量
    dragView.kCountInRow = 4;
    dragView.dragViewDelegete = self;
    //标记第几个选择组件
    dragView.send = 1;
    _dragView = dragView;
    [self.view addSubview:dragView];
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [[NSMutableArray alloc] init];
    
}




#pragma mark - HTImageDragViewDelegate
//点击了添加按钮
- (void)imageDragViewAddButtonClicked:(NSInteger)send{
    
    if (1 == send) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
        
        //图片
        imagePickerVc.allowTakePicture = YES;
        imagePickerVc.allowPickingImage = YES;
        //视频
        imagePickerVc.allowTakeVideo = NO;
        imagePickerVc.allowPickingVideo = NO;
        
        imagePickerVc.sortAscendingByModificationDate = YES;
        
        // 在这里设置imagePickerVc的外观
        [imagePickerVc.navigationBar setBackgroundImage:[UIImage imageNamed:@"bj-1"] forBarMetrics:UIBarMetricsDefault];
        
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
    
}
//点击了删除按钮
- (void)imageDragViewDeleteButtonClickedAtIndex:(NSInteger)index send:(NSInteger)send{
    if (1 == send) {
        [_selectedPhotos removeObjectAtIndex:index];
        [_selectedAssets removeObjectAtIndex:index];
    }
}
//点击了某张图片
- (void)imageDragViewButtonClickedAtIndex:(NSInteger)index send:(NSInteger)send{
    
    PHAsset * asset = nil;
    NSMutableArray *showAssets = nil;
    NSMutableArray *showphotos = nil;
    
    if (1 == send) {
        asset = _selectedAssets[index];
        showAssets = _selectedAssets;
        showphotos = _selectedPhotos;
    }
    
    if(nil==asset){
        return;
    }
    
    BOOL isVideo = NO;
    isVideo = asset.mediaType == PHAssetMediaTypeVideo;
    if ([[asset valueForKey:@"filename"] containsString:@"GIF"]) {
        TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
        TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
        vc.model = model;
        [self presentViewController:vc animated:YES completion:nil];
    } else if (isVideo) { // perview video / 预览视频
        TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
        TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
        vc.model = model;
        [self presentViewController:vc animated:YES completion:nil];
    } else { // preview photos / 预览照片
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:showAssets selectedPhotos:showphotos index:index];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
    
}
//移动了图片
- (void)imageDragViewDidMoveButtonFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex send:(NSInteger)send{
    
}

#pragma mark - TZImagePickerControllerDelegate
// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    
}
//选择图片回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    
    [self.dragView removeAllImages];
    for (UIImage *img in _selectedPhotos) {
        [self.dragView addImage:img];
    }
}

//选择完视频时回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    //选择视频时 最好单独获取一个视频 上传
    //    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    //    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    //
    //    [self.dragView removeAllImages];
    //    for (UIImage *img in _selectedPhotos) {
    //        [self.dragView addImage:img];
    //    }
    
    //****说明
    //上传视频时 先导出视频 传入asset 导出 data
//    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetLowQuality success:^(NSString *outputPath) {
//
//        NSData *data = [NSData dataWithContentsOfFile:outputPath];
    //上传操作
//        [self uploadVideo:[asset valueForKey:@"filename"] videoData:data];
//
//    } failure:^(NSString *errorMessage, NSError *error) {
//        NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
//    }];

    
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
