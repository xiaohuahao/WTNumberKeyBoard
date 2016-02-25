//
//  WTNumberKeyBoard.m
//
//  Created by Sean on 16/1/25.
//  Copyright © 2016年 Sean. All rights reserved.
//

#import "WTNumberKeyBoard.h"

@interface WTNumberKeyBoard ()
{
    NSArray* arrLetter;//英文
    NSMutableArray* numberArray;//数字集合
    
    UILabel* leftLabel;//左下角文字
    UIButton* leftBtn;//左下角按钮
}
@end

@implementation WTNumberKeyBoard

- (instancetype)init;
{
    self = [super init];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, kWTNumberKeyBoardScreenWeight, 216);
        _returnStr = @"";
        
        arrLetter = [NSArray arrayWithObjects:@"ABC",@"DEF",@"GHI",@"JKL",@"MNO",@"RST",@"UVW",@"XYZW", nil];
        
        //创建按钮
        for (int i=0; i<4; i++)
        {
            for (int j=0; j<3; j++)
            {
                UIButton *button = [self creatButtonWithX:i Y:j];
                [self addSubview:button];
            }
        }
        
        //竖线
        for (int i = 0; i<2; i++)
        {
            if (i == 0)
            {
                UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake((kWTNumberKeyBoardScreenWeight-kWTNumberKeyBoardLineWidth*2)/3.0, 0, kWTNumberKeyBoardLineWidth, 216)];
                topLine.backgroundColor = kWTNumberKeyBoardColorLineColor;
                [self addSubview:topLine];
            }
            else if (i == 1)
            {
                UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake((kWTNumberKeyBoardScreenWeight-kWTNumberKeyBoardLineWidth*2)*2/3.0+kWTNumberKeyBoardLineWidth, 0, kWTNumberKeyBoardLineWidth, 216)];
                bottomLine.backgroundColor = kWTNumberKeyBoardColorLineColor;
                [self addSubview:bottomLine];
            }
        }
        
        //横线
        for (int i=0; i<3; i++)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kWTNumberKeyBoardHeight*(i+1), kWTNumberKeyBoardScreenWeight, kWTNumberKeyBoardLineWidth)];
            line.backgroundColor = kWTNumberKeyBoardColorLineColor;
            [self addSubview:line];
        }
        
    }
    return self;
}

#pragma mark - 创建键盘按钮
-(UIButton *)creatButtonWithX:(NSInteger)x Y:(NSInteger)y
{
    //设置位置信息
    CGFloat frameX = 0.0f;
    CGFloat frameW = 0.0f;
    switch (y)
    {
        case 0:
        {
            frameX = 0.0f;
            frameW = (kWTNumberKeyBoardScreenWeight-kWTNumberKeyBoardLineWidth*2)/3.0;
        }
            break;
        case 1:
        {
            frameX = (kWTNumberKeyBoardScreenWeight-kWTNumberKeyBoardLineWidth*2)/3.0+kWTNumberKeyBoardLineWidth;
            frameW = (kWTNumberKeyBoardScreenWeight-kWTNumberKeyBoardLineWidth*2)/3.0;
        }
            break;
        case 2:
        {
            frameX = (kWTNumberKeyBoardScreenWeight-kWTNumberKeyBoardLineWidth*2)*2/3.0+kWTNumberKeyBoardLineWidth*2;
            frameW = (kWTNumberKeyBoardScreenWeight-kWTNumberKeyBoardLineWidth*2)/3.0;
        }
            break;
            
        default:
            break;
    }
    CGFloat frameY = kWTNumberKeyBoardHeight*x;
    
    //创建button
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(frameX, frameY, frameW, kWTNumberKeyBoardHeight);
    
    //设置tag为按钮数字
    NSInteger num = y+3*x+1;
    button.tag = num;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIColor* colorNormal = kWTNumberKeyBoardColorNormal;
    UIColor* colorHightlighted = kWTNumberKeyBoardColorHightlighted;
    if (num == 10 || num == 12)
    {
        //设置左右下角按钮颜色
        colorNormal = kWTNumberKeyBoardColorHightlighted;
        colorHightlighted = kWTNumberKeyBoardColorNormal;
    }
    button.backgroundColor = colorNormal;
    //添加填充色
    CGSize imageSize = CGSizeMake(frameW, kWTNumberKeyBoardHeight);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorHightlighted set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setImage:pressedColorImg forState:UIControlStateHighlighted];
    
    if (num<10)
    {
        UILabel *labelNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, frameW, 28)];
        labelNum.text = [NSString stringWithFormat:@"%ld",num];
        labelNum.textColor = [UIColor blackColor];
        labelNum.textAlignment = NSTextAlignmentCenter;
        labelNum.font = kWTNumberKeyBoardNumFont;
        [button addSubview:labelNum];
        
        if (num != 1)
        {
            UILabel *labelLetter = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, frameW, 16)];
            labelLetter.text = [arrLetter objectAtIndex:num-2];
            labelLetter.textColor = [UIColor blackColor];
            labelLetter.textAlignment = NSTextAlignmentCenter;
            labelLetter.font = [UIFont systemFontOfSize:12];
            [button addSubview:labelLetter];
        }
    }
    else if (num == 11)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frameW, 28)];
        label.text = @"0";
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kWTNumberKeyBoardNumFont;
        [button addSubview:label];
    }
    else if (num == 10)
    {
        leftLabel = [[UILabel alloc] init];
        leftLabel.frame = CGRectMake(0, 15, frameW, 28);
        leftLabel.text = @"";
        leftLabel.textColor = [UIColor blackColor];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        [button addSubview:leftLabel];
        button.userInteractionEnabled = NO;
        leftBtn = button;
    }
    else
    {
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(frameW/2.0-11, 19, 22, 17)];
        arrow.image = [UIImage imageNamed:@"arrowInKeyboard"];
        [button addSubview:arrow];
    }
    
    return button;
}

#pragma mark - 按钮点击事件
-(void)clickButton:(UIButton *)sender
{
    if (sender.tag == 10 && (_type == WTNumberKeyBoardCustom))
    {
        //左下角按钮点击事件
        if ([self.delegate respondsToSelector:@selector(numberKeyboardShouldReturn:)])
        {
            if (![self.delegate numberKeyboardShouldReturn:self])
            {
                return;
            }
        }
        [self keyBoardReturn];
    }
    else if(sender.tag == 12)
    {
        //回删
        if ([self.delegate respondsToSelector:@selector(numberKeyboardShouldBackspace:)])
        {
            if (![self.delegate numberKeyboardShouldBackspace:self])
            {
                return;
            }
        }
        [self textSubChange];
    }
    else
    {
        NSString* numberStr = @"";
        //输入数字
        NSInteger num = sender.tag;
        if (sender.tag == 10 && _type == WTNumberKeyBoardWithpointpoint)
        {
            numberStr = @".";
        }
        else if (sender.tag == 10 && _type == WTNumberKeyBoardNormal)
        {
            return;
        }
        else
        {
            if (sender.tag == 11)
            {
                num = 0;
            }
            numberStr = [NSString stringWithFormat:@"%@",@(num)];
        }
        
        if ([self.delegate respondsToSelector:@selector(numberKeyboardShouldInput:inPutNumBer:)])
        {
            if (![self.delegate numberKeyboardShouldInput:self inPutNumBer:numberStr])
            {
                return;
            }
        }
        [self textAddChange:numberStr];
    }
}

#pragma mark - 变化
-(void)textAddChange:(NSString*)number;
{
    if ([number isEqualToString:@"."])
    {
        for (NSString* str in numberArray)
        {
            if ([str isEqualToString:@"."])
            {
                return;
            }
        }
    }
    [self addNumber:number];
    [self makeSuperText];
}
-(void)textSubChange;
{
    if (_superTextField.text.length)
    {
        [self deleteNumber:_superTextField.text.length-1];
    }
    [self makeSuperText];
}
-(void)keyBoardReturn;
{
    if (_returnStr)
    {
        [_superTextField endEditing:YES];
    }
}

#pragma mark - numberArray
-(void)makeSuperTextField:(UITextField* )superTextField;
{
    numberArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i<_superTextField.text.length; i++)
    {
        [numberArray addObject:[_superTextField.text substringWithRange:NSMakeRange(i+1, 1)]];
    }
    _superTextField = superTextField;
}
-(void)addNumber:(NSString*)number;
{
    [numberArray addObject:number];
}
-(void)deleteNumber:(NSInteger)index;
{
    [numberArray removeObjectAtIndex:index];
}

#pragma mark - superTextField
-(void)makeSuperText;
{
    NSMutableString* text = [[NSMutableString alloc]initWithCapacity:0];
    for (NSNumber* numStr in numberArray)
    {
        NSString* str = [NSString stringWithFormat:@"%@",numStr];
        [text insertString:str atIndex:text.length];
    }
    
    if (text.length)
    {
        _superTextField.text = text;
    }
    else
    {
        _superTextField.text = @"";
    }
}

#pragma mark - returnStr和type
-(void)makeReturnStr:(NSString* )str;
{
    _returnStr = str;
    [self makeDateReturnStrAndType];
}
-(void)makeType:(WTNumberKeyBoardType)type;
{
    _type = type;
    [self makeDateReturnStrAndType];
}
-(void)makeDateReturnStrAndType;
{
    if (_type == WTNumberKeyBoardCustom)
    {
        leftLabel.text = _returnStr;
    }
    else if (_type == WTNumberKeyBoardWithpointpoint)
    {
        leftLabel.text = @".";
    }
    
    if (_type == WTNumberKeyBoardNormal)
    {
        leftBtn.userInteractionEnabled = NO;
    }
    else
    {
        leftBtn.userInteractionEnabled = YES;
    }
}

@end
