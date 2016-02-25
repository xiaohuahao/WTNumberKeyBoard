//
//  WTNumberKeyBoard.h
//
//  Created by Sean on 16/1/25.
//  Copyright © 2016年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTNumberKeyBoardDefault.h"
@class WTNumberKeyBoard;

typedef enum {
    WTNumberKeyBoardNormal = 0,
    WTNumberKeyBoardWithpointpoint,
    WTNumberKeyBoardCustom,
}WTNumberKeyBoardType;

@protocol WTNumberKeyBoardDelegate <NSObject>

@optional
- (BOOL) numberKeyboardShouldInput:(WTNumberKeyBoard*)keyBoardView inPutNumBer:(NSString*) number;
- (BOOL) numberKeyboardShouldBackspace:(WTNumberKeyBoard*)keyBoardView;
- (BOOL) numberKeyboardShouldReturn:(WTNumberKeyBoard*)keyBoardView;

@end

@interface WTNumberKeyBoard : UIView

@property (nonatomic,assign) id<WTNumberKeyBoardDelegate> delegate;
@property (nonatomic,setter=makeType:) WTNumberKeyBoardType type;

@property (nonatomic,setter=makeReturnStr:) NSString* returnStr;
@property (nonatomic,setter=makeSuperTextField:) UITextField* superTextField;

@end
