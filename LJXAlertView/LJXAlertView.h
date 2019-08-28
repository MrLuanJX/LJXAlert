//
//  LJXAlertView.h
//  LJXCustomAlert
//
//  Created by 栾金鑫 on 2019/8/28.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJXAlertBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum :NSInteger{
    signleBtn,
    twoBtn,
    threeBtn,
} LJXAlertType;

typedef void(^LJXAlertResultBlock)(void);
typedef void(^LJXAlertOtherResultBlock)(void);
typedef void(^LJXAlertCancelBlock)(void);

@interface LJXAlertView : LJXAlertBaseView

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
              otherResultBlock:(LJXAlertOtherResultBlock) otherResultBlock;



@end

NS_ASSUME_NONNULL_END
