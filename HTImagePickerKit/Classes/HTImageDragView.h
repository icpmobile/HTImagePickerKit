//
//  HTImageDragView.h
//  HTImageDragView
//
//  Created by zlj on 19/06/25.
//  Copyright © 2016年 hoteamsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTImageDragViewDelegate <NSObject>
@optional
/** 点击了添加按钮 */
- (void)imageDragViewAddButtonClicked:(NSInteger) send;
/** 点击了删除按钮 */
- (void)imageDragViewDeleteButtonClickedAtIndex:(NSInteger)index send:(NSInteger)send;
/** 点击了按钮 */
- (void)imageDragViewButtonClickedAtIndex:(NSInteger)index send:(NSInteger)send;
/** 移动了按钮 */
- (void)imageDragViewDidMoveButtonFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex send:(NSInteger)send;

@end

@interface HTImageDragView : UIScrollView
@property (nonatomic,assign) CGFloat kCountInRow;   //每行个数
@property (nonatomic,assign) CGFloat kMarginLRTB;   //上下左右间距
@property (nonatomic,assign) CGFloat kMarginB;      //按钮间距
@property (nonatomic,assign) CGFloat kMaxCount;     //最大数量
//同一页面复用 是 区分 第几个控件 例如 同一个页面同时有选择图片 选择视频时
@property (nonatomic,assign) NSInteger send;

/** 代理 */
@property (nonatomic,weak) id<HTImageDragViewDelegate> dragViewDelegete;
/** 添加一张照片 */
- (void)addImage:(UIImage *)image;
/** 获取所有照片 */
- (NSArray *)getAllImages;
/** 获取所有按钮 */
- (NSArray *)getAllImageButtons;
/** 删除所有按钮 */
- (void)removeAllImages;
/** 获取本视图适当的高度 */
- (CGFloat)getHeightThatFit;
@end
