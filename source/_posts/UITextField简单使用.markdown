# UITextField简单使用
title: UITextField简单使用
tags : [IOS开发SDK]
date: 2015-11-15 11:50:07
---
1.UITextField的初始化和设置
  textField = [[UITextField alloc] initWithFrame:CGRectMake(120.0f, 80.0f, 150.0f, 30.0f)]; 
  [textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型 
 
  textField.placeholder = @"password"; //默认显示的字 
 
  textField.secureTextEntry = YES; //密码 
 
  textField.autocorrectionType = UITextAutocorrectionTypeNo; 
  textField.autocapitalizationType = UITextAutocapitalizationTypeNone; 
  textField.returnKeyType = UIReturnKeyDone; 
  textField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X 
 
  textField.delegate = self;
2.要实现的Delegate方法,关闭键盘
  - (BOOL)textFieldShouldReturn:(UITextField *)textField 
  { 
      [self.textField resignFirstResponder]; 
      return YES; 
  } 
3. 可以在UITextField使用下面方法，按return键返回
-(IBAction) textFieldDone:(id) sender
{
 [textFieldName resignFirstResponder]; 
}
链接TextField控件的"Did end on exit"
最右侧加图片是以下代码,
    UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right.png"]];
    text.rightView=imgv;
    text.rightViewMode = UITextFieldViewModeAlways;    

如果是在最左侧加图片就换成:
text.leftView=imgv;
text.leftViewMode = UITextFieldViewModeAlways;    
UITextField 继承自 UIControl,此类中有一个属性contentVerticalAlignment
所以想让UITextField里面的text垂直居中可以这样写:
text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
查看函数的方法：
按住command键双击进入函数声明
按住alt键双击进入doc文档
///////////////////////////////////////////////////////////////
文本框常用方法:
如何用程序删除文本框中选中的文本
[textView delete: nil];
///////////////////////////////////////////////////////////////
如何限制文本框只能输入数字:
建立NSNumberFormatter的子类，增加这个方法，将formatter链接至文本框。
 
- (BOOL) isPartialStringValid: (NSString **) partialStringPtr
        proposedSelectedRange: (NSRangePointer) proposedSelRangePtr
               originalString: (NSString *) origString
        originalSelectedRange: (NSRange) origSelRange
             errorDescription: (NSString **) error
{
    NSCharacterSet *nonDigits;
    NSRange newStuff;
    NSString *newStuffString;
            
    nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    newStuff = NSMakeRange(origSelRange.location,
                           proposedSelRangePtr->location
                           - origSelRange.location);
    newStuffString = [*partialStringPtr substringWithRange: newStuff];
            
    if ([newStuffString rangeOfCharacterFromSet: nonDigits
                                                                                             options: NSLiteralSearch].location != NSNotFound) {
        *error = @"不是数字";
        return (NO);
    } else {
        *error = nil;
        return (YES);
    }
            
}
///////////////////////////////////////////////////////////////
从文本框获取十六进制数据的代码
char singleNumberString[3] = {'\0','\0','\0'};
uint32_t singleNumber = 0;
uint32_t i = 0;
 NSMutableData *data = [NSMutableData data];
 //从文本框获取到得数据
 const char *buf = [[_hexToSendTextField text] UTF8String];
 //转换为十六进制
 for(i = 0; i < strlen(buf); i+=2)
 {
 if(((i+1) < len && isxdigit(buf) && (isxdigit(buf[i+1])))
 {
 singleNumberString[0] = buf;
 singleNumberString[1] = buf[i+1];
 sscanf(singleNumberString, "%x", &singleNumber);
 [data appendBytes:(void*)(&tmp) length:1];
 }
 else
 {
 break;
 }
 }
 //输出
 NSLog(@"%@", data);
/////////////////////////////////////////////////////////////
点击 UITextView 输入文字，光标都从最初点开始
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    NSRange range;
    range.location = 0;
    range.length = 0;
    textView.selectedRange = range;
}
///////////////////////////////////////////////////////////
软键盘
在登录页面要实现用户名和密码，密码要是点点格式，引入当前页面光标要停留在用户名选项，软键盘要弹出界面。如下图：
弹出键盘：
[username becomeFirstResponder];
取消键盘：
[username resignFirstResponder];
密码保护：
password.secureTextEntry=YES;
//////////////////////////////////////////////////////////////////
1.UITextField的初始化和设置
  textField = [[UITextField alloc] initWithFrame:CGRectMake(120.0f, 80.0f, 150.0f, 30.0f)]; 
  [textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型 
  textField.placeholder = @"password"; //默认显示的字 
  textField.secureTextEntry = YES; //密码 
  textField.autocorrectionType = UITextAutocorrectionTypeNo; 
  textField.autocapitalizationType = UITextAutocapitalizationTypeNone; 
  textField.returnKeyType = UIReturnKeyDone; 
  textField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X 
  textField.delegate = self;
2.要实现的Delegate方法,关闭键盘
  - (BOOL)textFieldShouldReturn:(UITextField *)textField 
  { 
      [self.textField resignFirstResponder]; 
      return YES; 
  } 
3. 可以在UITextField使用下面方法，按return键返回
-(IBAction) textFieldDone:(id) sender
{
 [textFieldName resignFirstResponder]; 
}
链接TextField控件的"Did end on exit"
////////////////////////////////////////////////////////////////////
限制输入文本的长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= MAX_LENGTH)
        return NO; // return NO to not change text
    return YES;
}
if (textField.text.length >= 10 && range.length == 0)
    return NO;
return YES;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string 
{ 
 if ([textField.text length] > MAXLENGTH) 
 { 
  textField.text = [textField.text substringToIndex:MAXLENGTH-1]; 
  return NO; 
 } 
 return YES; 
} 
//////////////////////////////////////////////////////////////////////
使用UITextFieldDelegate来隐藏键盘 
在iPhone界面上，时常会需要当用户输入完内容后，隐藏键盘。 当然有很多方法，今天只介绍使用UITextFieldDelegate这个协议实现隐藏键盘。
其实很简单， 需要三步：
1. 在你的控制器类中，加入UITextFieldDelegate这个协议
如：@interface AddItemViewController : UIViewController <UITextFieldDelegate>
2. 在使用了UITextFieldDelegate协议的控制器类的实现中，加入- (BOOL)textFieldShouldReturn:方法。
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
 
        [textField resignFirstResponder];
        return YES;
}
 //设置焦点：

[UITextField becomeFirstResponder];

3. 将xib文件中的TextField控件的delegate变量指向到之前使用UITextFieldDelegate协议的那个控制器类,将 TextField的delegate IBOutlet变量右键链接到前面的控制器类的实例上。或者使用代码方式，指定相关TextField的delegate变量。

- (void)viewDidLoad 

{

    [super viewDidLoad];

        itemNameField.delegate = self;

        priceField.delegate = self;

}




