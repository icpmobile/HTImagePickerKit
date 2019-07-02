//
//  HTImageButton.m
//  HTImageDragView
//
//  Created by zlj on 19/06/25.
//  Copyright © 2016年 hoteamsoft. All rights reserved.
//

#import "HTImageButton.h"

@interface HTImageButton ()
@property (nonatomic,strong) UIButton *deleteButton;
@end

@implementation HTImageButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //下面两句可以使image全屏显示在button上（self.imageView.contentMode没有用）
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
        
        //删除按钮
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSString *path = [bundle pathForResource:@"ht_imgpick_delete@2x" ofType:nil  inDirectory:@"HTImagePickerKit.bundle"];

        
        [self.deleteButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        [self.deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.deleteButton];
        [self addTarget:self action:@selector(imageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.deleteButton.frame = CGRectMake(0, 0, 25, 25);
}

- (void)setIsAddButton:(BOOL)isAddButton{
    _isAddButton = isAddButton;
    self.deleteButton.hidden = isAddButton;
}

- (void)deleteButtonClicked:(UIButton *)deleteButton
{
    if (self.deleteButtonClickedBlock) {
        self.deleteButtonClickedBlock();
    }
}

- (void)imageButtonClicked:(UIButton *)imageButton
{
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock();
    }
}

- (BOOL)pointInDeleteButton:(CGPoint)point
{
    return CGRectContainsPoint(self.deleteButton.frame, point);
}
@end
