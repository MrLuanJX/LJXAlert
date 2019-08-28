//
//  LJXAlertView.m
//  LJXCustomAlert
//
//  Created by 栾金鑫 on 2019/8/28.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJXAlertView.h"

@interface LJXAlertView ()

@property (nonatomic , assign) LJXAlertType alertType;

@property (nonatomic , copy) LJXAlertResultBlock resultBlock;

@property (nonatomic , copy) LJXAlertOtherResultBlock otherResultBlock;

@property (nonatomic , copy) LJXAlertCancelBlock cancelBlock;

@end

@implementation LJXAlertView

+ (void) showWithAlertWithType:(LJXAlertType) alertType
                         title:(NSString *) title
          titleBackgroundColor:(UIColor *) titlebackgroundColor
                       content:(NSString *) content
                cancelBtnTitle:(NSString *) cancelBtnTitle
                resultBtnTitle:(NSString *) resultBtnTitle
           otherResultBtnTitle:(NSString *) otherResultBtnTitle
            cancelBtnBackColor:(UIColor *) cancelBtnBackColor
            resultBtnBackColor:(UIColor *) resultBtnBackColor
       otherResultBtnBackColor:(UIColor *) otherResultBtnBackColor
                   cancelBlock:(LJXAlertCancelBlock) cancelBlock
                   resultBlock:(LJXAlertResultBlock) resultBlock
              otherResultBlock:(LJXAlertOtherResultBlock) otherResultBlock {
    LJXAlertView * alertView = [[LJXAlertView alloc] initWithType:alertType title:title titleBackgroundColor:titlebackgroundColor content:content cancelBtnTitle:cancelBtnTitle resultBtnTitle:resultBtnTitle otherResultBtnTitle:otherResultBtnTitle cancelBtnBackColor:cancelBtnBackColor resultBtnBackColor:resultBtnBackColor otherResultBtnBackColor:otherResultBtnBackColor cancelBlock:cancelBlock resultBlock:resultBlock otherResultBlock:otherResultBlock];
    
    [alertView show];
}

#pragma mark - 初始化时间选择器
- (instancetype)initWithType:(LJXAlertType) alertType
                       title:(NSString *) title
        titleBackgroundColor:(UIColor *) titlebackgroundColor
                     content:(NSString *) content
              cancelBtnTitle:(NSString *) cancelBtnTitle
              resultBtnTitle:(NSString *) resultBtnTitle
         otherResultBtnTitle:(NSString *) otherResultBtnTitle
          cancelBtnBackColor:(UIColor *) cancelBtnBackColor
          resultBtnBackColor:(UIColor *) resultBtnBackColor
     otherResultBtnBackColor:(UIColor *) otherResultBtnBackColor
                 cancelBlock:(LJXAlertCancelBlock) cancelBlock
                 resultBlock:(LJXAlertResultBlock) resultBlock
            otherResultBlock:(LJXAlertOtherResultBlock) otherResultBlock {
    
    if (self = [super init]) {
        [self initUI];
        
        [self setupTitleViewBackColor:titlebackgroundColor Title:title];
        
        [self setupContent:content];
        
        [self setupType:[self typeWithLJXAlertType:alertType]];
        
        [self setupSureBtnBackColor:resultBtnBackColor Title:resultBtnTitle];
        
        [self setupCancelBtnBackColor:cancelBtnBackColor Title:cancelBtnTitle];
        
        [self setupOtherBtnBackColor:otherResultBtnBackColor Title:otherResultBtnTitle];
        
        _resultBlock = resultBlock;
        _cancelBlock = cancelBlock;
        _otherResultBlock = otherResultBlock;
    }
    return self;
}

- (void) close {
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    [self close];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)cancelClick {
    [self close];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)sureClick {
    [self close];
    if (self.resultBlock) {
        self.resultBlock();
    }
}

- (void)otherClick {
    [self close];
    if (self.otherResultBlock) {
        self.otherResultBlock();
    }
}

- (void)show{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    
    [window addSubview:self];
    
    [self shakeToShow:self.alertView];
}

/* 显示提示框的动画 */
- (void)shakeToShow:(UIView*)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1,1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2,1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0,1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (NSInteger) typeWithLJXAlertType:(LJXAlertType) type {
    if (type == signleBtn) {
        return 0;
    } else if (type == twoBtn) {
        return 1;
    } else if (type == threeBtn) {
        return 2;
    }
    return 0;
}

@end
