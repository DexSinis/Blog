#import "ViewController.h"


#define SRV_CONNECTED 0
#define SRV_CONNECT_SUC 1
#define SRV_CONNECT_FAIL 2
#define HOST_IP @"192.168.1.107"
#define HOST_PORT 9999

@interface ViewController ()
{
    NSString *_content;
}
-(int) connectServer: (NSString *) hostIP port:(int) hostPort;
-(void)showMessage:(NSString *) msg;
@end

@implementation ViewController

@synthesize clientSocket,tbInputMsg,lblOutputMsg;

#pragma mark - view lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self connectServer:HOST_IP port:HOST_PORT];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [clientSocket release], clientSocket = nil;
    [tbInputMsg release], tbInputMsg = nil;
    [lblOutputMsg release], lblOutputMsg = nil;
}

- (int)connectServer:(NSString *)hostIP port:(int)hostPort
{
    if (clientSocket == nil)
    {
        // 在需要联接地方使用connectToHost联接服务器
        clientSocket = [[AsyncSocket alloc] initWithDelegate:self];
        NSError *err = nil;
        if (![clientSocket connectToHost:hostIP onPort:hostPort error:&err])
        {
            NSLog(@"Error %d:%@", err.code, [err localizedDescription]);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[@"Connection failed to host" stringByAppendingString:hostIP] message:[NSString stringWithFormat:@"%d:%@",err.code,err.localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            return SRV_CONNECT_FAIL;
        } else {
            NSLog(@"Connected!");
            return SRV_CONNECT_SUC;
        }
    }
    else {
        return SRV_CONNECTED;
    }
}

#pragma mark - IBAction
// 发送数据
- (IBAction) sendMsg:(id)sender
{
    NSString *inputMsgStr = tbInputMsg.text;
    NSString * content = [inputMsgStr stringByAppendingString:@"\r\n"];
    NSLog(@"%@",content);
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    // NSData *data = [content dataUsingEncoding:NSISOLatin1StringEncoding];
    [clientSocket writeData:data withTimeout:-1 tag:0];
}
// 连接/重新连接
- (IBAction) reconnect:(id)sender
{
    int stat = [self connectServer:HOST_IP port:HOST_PORT];
    switch (stat) {
        case SRV_CONNECT_SUC:
            [self showMessage:@"connect success"];
            break;
        case SRV_CONNECTED:
            [self showMessage:@"It's connected,don't agian"];
            break;
        default:
            break;
    }
}
- (void)showMessage:(NSString *)msg
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Alert!"
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}
- (IBAction)textFieldDoneEditing:(id)sender
{
    [tbInputMsg resignFirstResponder];
}
- (IBAction)backgroundTouch:(id)sender
{
    [tbInputMsg resignFirstResponder];
}

#pragma mark socket delegate
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    [clientSocket readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"Error");
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSString *msg = @"Sorry this connect is failure";
    [self showMessage:msg];
    [msg release];
    clientSocket = nil;
}

- (void)onSocketDidSecure:(AsyncSocket *)sock
{
}

// 接收到数据（可以通过tag区分）
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    _content = lblOutputMsg.text;
    NSLog(@"Hava received datas is :%@",aStr);
    NSString *newStr = [NSString stringWithFormat:@"\n%@", aStr];
    lblOutputMsg.text = [_content stringByAppendingString:newStr];
    [aStr release];
    [clientSocket readDataWithTimeout:-1 tag:0];
}

@end