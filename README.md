# WTNumberKeyBoard
自定义数字键盘，可在iPhone和iPad上使用

可选择3个代理方法
- (BOOL) numberKeyboardShouldInput:(WTNumberKeyBoard*)keyBoardView inPutNumBer:(NSString*) number;
- (BOOL) numberKeyboardShouldBackspace:(WTNumberKeyBoard*)keyBoardView;
- (BOOL) numberKeyboardShouldReturn:(WTNumberKeyBoard*)keyBoardView;

示例
-(BOOL)numberKeyboardShouldInput:(WTNumberKeyBoard *)keyBoardView inPutNumBer:(NSString *)number
{
    keyBoardView.superTextField.text = [NSString stringWithFormat:@"%@",number];
    return NO;
}

-(BOOL)numberKeyboardShouldInput:(WTNumberKeyBoard *)keyBoardView inPutNumBer:(NSString *)number
{
    NSLog(@"%@",keyBoardView.superTextField.text);
    return YES;
}
