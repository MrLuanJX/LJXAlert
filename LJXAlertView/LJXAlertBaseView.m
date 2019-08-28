//
//  LJXAlertBaseView.m
//  LJXCustomAlert
//
//  Created by 栾金鑫 on 2019/8/28.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#define kTopViewHeight 50

/********************屏幕宽和高*******************/
#define LJXScreenW [UIScreen mainScreen].bounds.size.width
#define LJXScreenH [UIScreen mainScreen].bounds.size.height
//根据屏幕宽度计算对应View的高
#define LJXFit(value) ((value * LJXScreenW) / 375.0f)
/**字体*/
#define LJXFontSize(x) [UIFont systemFontOfSize:(LJXScreenW > 374 ? (LJXScreenW > 375 ? x * 1.1 : x ) : x / 1.1)]
/**加粗字体*/
#define LJXFontBoldSize(x) [UIFont boldSystemFontOfSize:(LJXScreenW > 374 ? (CGFloat)x  : (CGFloat)x / 1.1)]

#import "LJXAlertBaseView.h"

@interface LJXAlertBaseView()

// 背景视图
@property (nonatomic, strong) UIView *backgroundView;

// 顶部标题
@property (nonatomic, strong) UILabel *titleLabel;
// 内容
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LJXContentLabel * contentLabel;
// 底部视图
@property (nonatomic, strong) UIView *btmView;
// sureBtn
@property (nonatomic, strong) UIButton *sureBtn;
// cancelBtn
@property (nonatomic, strong) UIButton *cancelBtn;
// otherBtn
@property (nonatomic, strong) UIButton *otherBtn;

@property (nonatomic, copy) NSString *content;

@end

@implementation LJXAlertBaseView

- (void)initUI {
    self.frame = [[UIScreen mainScreen] bounds];
    // 背景视图
    [self addSubview:self.backgroundView];
    // 弹出视图
    [self addSubview:self.alertView];
    // 顶部标题
    [self.alertView addSubview: self.titleLabel];
    // 内容
    [self.alertView addSubview: self.scrollView];
    // 内容label
    [self.scrollView addSubview:self.contentLabel];
    // cancelBtn
    [self.alertView addSubview: self.cancelBtn];
    // btmView
    [self.alertView addSubview: self.btmView];
    [self.btmView addSubview: self.cancelBtn];
    [self.btmView addSubview: self.sureBtn];
    [self.btmView addSubview: self.otherBtn];
}

#pragma mark - 背景遮罩图层
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2f];
        // 设置子视图的大小随着父视图变化
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView:)];
        [_backgroundView addGestureRecognizer:myTap];
    }
    return _backgroundView;
}

#pragma mark - 弹出视图
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(LJXFit(30), self.backgroundView.frame.size.height/2 - LJXFit(150), self.backgroundView.frame.size.width - LJXFit(60), LJXFit(300))];
        _alertView.backgroundColor = [UIColor whiteColor];
        // 设置子视图的大小随着父视图变化
        _alertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _alertView;
}

#pragma mark - 顶部标题
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, LJXFit(50))];
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
        _titleLabel.font = LJXFontBoldSize(20);
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"标题";
    }
    return _titleLabel;
}

#pragma mark - 内容
- (UIScrollView *)scrollView {
    if (!_scrollView ) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.alertView.frame), CGRectGetHeight(self.alertView.frame) - LJXFit(50))];
        _scrollView.contentSize =  CGSizeMake(0, self.alertView.frame.size.width);
    }
    return _scrollView;
}

- (LJXContentLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[LJXContentLabel alloc] initWithFrame:self.scrollView.frame];
        _contentLabel.contentEdgeInsets = UIEdgeInsetsMake(LJXFit(10), LJXFit(10), LJXFit(10), -LJXFit(20));
        _contentLabel.font = LJXFontSize(17);
    }
    return _contentLabel;
}

- (UIView *)btmView {
    if (!_btmView) {
        _btmView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), CGRectGetWidth(self.alertView.frame), LJXFit(50))];
        _btmView.backgroundColor = [UIColor yellowColor];
    }
    return _btmView;
}
// cancelBtn
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton new];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = LJXFontSize(15);
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] initWithFrame:self.btmView.frame];
        _sureBtn.backgroundColor = [UIColor cyanColor];
        [_sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = LJXFontSize(15);
        [_sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIButton *)otherBtn {
    if (!_otherBtn) {
        _otherBtn = [UIButton new];
        _otherBtn.backgroundColor = [UIColor purpleColor];
        [_otherBtn setTitle:@"其 他" forState:UIControlStateNormal];
        [_otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _otherBtn.titleLabel.font = LJXFontSize(15);
        [_otherBtn addTarget:self action:@selector(otherClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherBtn;
}

#pragma mark - 点击背景遮罩图层事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    
}

- (void) setupTitleViewBackColor:(UIColor *)backColor Title:(nonnull NSString *)title {
    self.titleLabel.backgroundColor = backColor;
    self.titleLabel.text = title;
}

- (void)setupContent:(NSString *)content {
    _content = content;
    self.alertView.frame = CGRectMake(LJXFit(30), self.backgroundView.frame.size.height/2 - (LJXFit(50)+ [self heightWihtContent:content])/2, self.backgroundView.frame.size.width - LJXFit(60), LJXFit(50)+ [self heightWihtContent:content]);
}

- (void) setupSureBtnBackColor:(UIColor *)backColor Title:(NSString *)title {
    self.sureBtn.backgroundColor = backColor;
    [self.sureBtn setTitle:[title isEqualToString:@""] ? @"确定" : title forState:UIControlStateNormal];
}

- (void) setupCancelBtnBackColor:(UIColor *)backColor Title:(NSString *)title {
    self.cancelBtn.backgroundColor = backColor;
    [self.cancelBtn setTitle:[title isEqualToString:@""] ? @"取消" : title forState:UIControlStateNormal];
}

- (void) setupOtherBtnBackColor:(UIColor *)backColor Title:(NSString *)title {
    self.otherBtn.backgroundColor = backColor;
    [self.otherBtn setTitle:[title isEqualToString:@""] ? @"其他" : title forState:UIControlStateNormal];
}

- (void)setupType:(NSInteger)type {
    if (type == 0) {
        self.sureBtn.frame = CGRectMake(0, 0, CGRectGetWidth(self.alertView.frame), LJXFit(50));
    } else if (type == 1) {
        self.cancelBtn.frame = CGRectMake(0, 0, CGRectGetWidth(self.alertView.frame)/2, LJXFit(50));
        self.sureBtn.frame = CGRectMake(CGRectGetWidth(self.alertView.frame)/2, 0, CGRectGetWidth(self.alertView.frame)/2, LJXFit(50));
    } else if (type == 2) {
        
        self.alertView.frame = CGRectMake(LJXFit(30), self.backgroundView.frame.size.height/2 - (LJXFit(150)+ [self heightWihtContent:self.content])/2, self.backgroundView.frame.size.width - LJXFit(60), LJXFit(150)+ [self heightWihtContent:self.content]);
        
        self.btmView.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), CGRectGetWidth(self.alertView.frame), LJXFit(150));
        
        self.sureBtn.frame = CGRectMake(0, 0, CGRectGetWidth(self.alertView.frame), LJXFit(50));
        self.cancelBtn.frame = CGRectMake(0,LJXFit(100), CGRectGetWidth(self.alertView.frame), LJXFit(50));
        self.otherBtn.frame = CGRectMake(0,LJXFit(50), CGRectGetWidth(self.alertView.frame), LJXFit(50));
    }
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (NSInteger) heightWihtContent:(NSString *)content {
    // 设置行间距
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0; // 设置行间距
    paragraphStyle.alignment = NSTextAlignmentJustified; //设置两端对齐显示
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
    
    self.contentLabel.attributedText = attributedStr;
    self.contentLabel.numberOfLines = 0;
    CGSize contentSize = [self.contentLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.alertView.frame), 9999)];
    
    CGFloat height = 0;
    if (contentSize.height >= LJXFit(300)) {
        height = LJXFit(300);
        self.scrollView.scrollEnabled = YES;
    } else if (contentSize.height <= LJXFit(100)) {
        height = LJXFit(100);
        self.scrollView.scrollEnabled = NO;
    } else {
        height = contentSize.height;
        self.scrollView.scrollEnabled = NO;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.alertView.frame.size.width, height);
    self.contentLabel.frame = CGRectMake(CGRectGetMinX(self.scrollView.frame), 0, contentSize.width, height);
    
    return  height;
}

- (void) cancelClick {
    
}

- (void) otherClick {
    
}

- (void) sureClick {
    
}

@end

