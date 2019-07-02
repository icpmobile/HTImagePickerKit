//
//  HTImageButton.h
//  HTImageDragView
//
//  Created by zlj on 19/06/25.
//  Copyright © 2016年 hoteamsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTImageButton : UIButton
@property (nonatomic,copy) void(^deleteButtonClickedBlock)();
@property (nonatomic,copy) void(^buttonClickedBlock)();
@property (nonatomic,assign) BOOL isAddButton;
- (BOOL)pointInDeleteButton:(CGPoint)point;
@end
