//
//  LJXAlertBaseView.h
//  LJXCustomAlert
//
//  Created by 栾金鑫 on 2019/8/28.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJXContentLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LJXAlertBaseView : UIView

// 弹出视图
@property (nonatomic, strong) UIView *alertView;

/** 初始化子视图 */
- (void)initUI;

/** 点击背景遮罩图层事件 */
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender;

// 设置title背景色
- (void) setupTitleViewBackColor:(UIColor *)backColor Title:(NSString *)title;
// 设置内容
- (void) setupContent:(NSString *) content;
// 设置样式
- (void) setupType:(NSInteger) type;
// 设置确定按钮文字、背景色
- (void) setupSureBtnBackColor:(UIColor *)backColor Title:(NSString *)title;
// 设置其他按钮文字、背景色
- (void) setupOtherBtnBackColor:(UIColor *)backColor Title:(NSString *)title;
// 设置取消按钮文字、背景色
- (void) setupCancelBtnBackColor:(UIColor *)backColor Title:(NSString *)title;

- (void) cancelClick;
- (void) otherClick;
- (void) sureClick;

@end

NS_ASSUME_NONNULL_END
