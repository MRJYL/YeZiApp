//
//  AccountViewController.m
//  LeafLoading
//
//  Created by 云一程 on 2017/4/10.
//  Copyright © 2017年 云一程. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountViewController+DataOperation.h"
#import "AccountCellView.h"
#import <IOKit/IOKitLib.h>

@interface AccountViewController ()<NSTableViewDelegate, NSTableViewDataSource,AccountCellViewDelegate, AddAppStoreAccountDelegate, InputViewControllerDelegate>
    
@property (nonatomic, strong) InputViewController *inputController;
@property (nonatomic, strong) AddAppStoreAccount *addAccount;

@property (weak) IBOutlet NSButton *leftBtn;
@property (weak) IBOutlet NSButton *rightBtn;

@property (weak) IBOutlet NSSegmentedControl *customerSegment;
@property (weak) IBOutlet NSTableView *listTableView;
@property (nonatomic, strong) NSMutableArray *activiteArray;
@property (nonatomic ,strong) NSMutableArray *customerArray;
@property (nonatomic, strong) AccountModel *modifyModel;
    
@end

@implementation AccountViewController

- (void)viewWillAppear{
    [super viewWillAppear];
    NSLog(@"%@",self.view);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    NSLog(@"%@",[NSString serialNumber]);
    self.customerArray =  [self getCustomerAccounts];
    [Helper uploadActiviteCode];
    [Helper getActiviteAccounts:^(NSArray<AccountModel *> *accounts) {
        self.activiteArray = [accounts mutableCopy];
        [self.listTableView reloadData];
    }];
    [self.listTableView reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanActivitCode) name:@"CleanActiviteCode" object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)cleanActivitCode{
    [self.listTableView reloadData];
}
- (void)addData{
    [self.customerArray addObject:[AccountModel AccountWithAppStoreId:@"ID" password:@"Password" nickName:@"昵称"]];
}
- (IBAction)getSerialNumberAction:(NSButton *)sender {
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:[NSString serialNumber] forType:NSPasteboardTypeString];
    [self showAlertWithMessage:@"复制设备码到剪贴板"];
}

- (IBAction)segmentAction:(NSSegmentedControl *)sender {
    if (sender.selectedSegment == 0) {
        self.leftBtn.title = @"购买激活码";
        self.rightBtn.hidden = NO;
        self.rightBtn.title = @"添加激活码";
    }else if(sender.selectedSegment == 1){
        self.leftBtn.title = @"添加账号";
        self.rightBtn.hidden = YES;
        self.rightBtn.title = @"赞助本店";
    }
    [self.listTableView reloadData];
}
    
- (IBAction)buttonAction:(NSButton *)sender {
    if ([sender.title isEqualToString:@"购买激活码"]) {
        if ([Helper isPay]) {
            [self showAlertWithMessage:@"已购买过授权码"];
            return ;
        }
        [self openUrl:@"https://yeziapp.taobao.com/"];
    }else if([sender.title isEqualToString:@"添加激活码"]){
        if ([Helper isPay]) {
            [self showAlertWithMessage:@"已添加过授权码"];
            return ;
        }
        [NSApplication.sharedApplication.mainWindow beginSheet:self.inputController.window completionHandler:nil];
    }else if([sender.title isEqualToString:@"添加账号"]){
        [NSApplication.sharedApplication.mainWindow beginSheet:self.addAccount.window completionHandler:nil];
    }else if([sender.title isEqualToString:@"赞助本店"]){
        [self openUrl:@"http://ac-katpqdx3.clouddn.com/15b8ab98040b5c16e618.png"];
    }
}

- (void)openUrl:(NSString *)url{
    NSString *openUrl = url;
    if (!openUrl.length) {
        openUrl = @"https://www.baidu.com";
    }
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:openUrl]];
}
-(void)openAppStoreWithID:(NSString *)appStoreId password:(NSString *)password{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [LoginAppStoreManager loginAppStoreWith:appStoreId password:password];
    });
}

#pragma mark - AccountOperationViewDelegte
- (void)openUrlOperation:(NSString *)url{
    if ([url hasPrefix:@"http"]) {
        [self openUrl:url];
    }else if([url isEqualToString:@"添加激活码"]){
        [NSApplication.sharedApplication.mainWindow beginSheet:self.inputController.window completionHandler:nil];
    }else if([url isEqualToString:@"添加账号"]){
        self.modifyModel = nil;
        [NSApplication.sharedApplication.mainWindow beginSheet:self.addAccount.window completionHandler:nil];
    }else{
        [LoginAppStoreManager loginAppStoreWith:@"123456789@123.com" password:@"A123456789@123com"];
    }
}

- (void)showAlertWithMessage:(NSString *)message {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = message;
    [alert beginSheetModalForWindow:self.view.window completionHandler:nil];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 48;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    switch (self.customerSegment.selectedSegment) {
        case 0:
            return [Helper isPay] ? self.activiteArray.count : 0;
            break;
        default:
            return self.customerArray.count;
            break;
    }
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    AccountCellView * cell = [tableView makeViewWithIdentifier:[tableColumn identifier] owner:self];

    if (!cell.delegate) {
        cell.delegate = self;
    }
    cell.modifyBtn.hidden = cell.delBtn.hidden = self.customerSegment.selectedSegment == 0;
    switch (self.customerSegment.selectedSegment) {
        case 0:
            if (row >= self.activiteArray.count) {
                return cell;
            }
            cell.model = self.activiteArray[row];
            break;
        default:
            if (row >= self.customerArray.count) {
                return cell;
            }
            cell.model = self.customerArray[row];
            break;
    }
    return cell;
}

- (void)modifyBtnClicked:(AccountModel *)model{
    self.modifyModel = model;
    self.addAccount.accountField.stringValue = model.appStoreId;
    self.addAccount.secretField.stringValue = model.appStorePassword;
    self.addAccount.descreptionField.stringValue = model.appStoreNickName;
    [NSApplication.sharedApplication.mainWindow beginSheet:self.addAccount.window completionHandler:nil];
    [self saveCustomerAccounts:self.customerArray];
}

- (void)delBtnClicked:(AccountModel *)model{
    [self.customerArray removeObject:model];
    [self.listTableView reloadData];
    [self saveCustomerAccounts:self.customerArray];
}

- (void)loginBtnClicked:(AccountModel *)model{
    [self openAppStoreWithID:model.appStoreId password:model.appStorePassword];
    [self.listTableView reloadData];
}
//添加激活码
- (void)didAddActivityCodeWithCode:(NSString *)code{
    [self showAlertWithMessage:[NSString stringWithFormat:@"我的激活码: %@\n正确激活码: %@,\n机器码:%@",code,[NSString activiteCode],[NSString serialNumber]]];
    if ([code isEqualToString:[NSString activiteCode]]) {
        [[NSUserDefaults standardUserDefaults] setObject:code forKey:@"activiteCode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self showAlertWithMessage:@"授权成功"];
        [self.listTableView reloadData];
    }else{
        [self showAlertWithMessage:@"授权失败"];
    }
}
//添加appStore{
- (void)addAccountWithUserName:(NSString *)userName password:(NSString *)password nickname:(NSString *)nickname{
    if (self.modifyModel) {
        for (AccountModel *model in self.customerArray) {
            if ([self.modifyModel isEqual:model]) {
                model.appStoreId = userName;
                model.appStorePassword = password;
                model.appStoreNickName = nickname;
                [self.listTableView reloadData];
                self.modifyModel = nil;
                return;
            }
        }
    }
    [self.customerArray addObject:[AccountModel AccountWithAppStoreId:userName password:password nickName:nickname]];
    [self.listTableView reloadData];
    [self saveCustomerAccounts:self.customerArray];
}

- (InputViewController *)inputController{
    if (!_inputController) {
        _inputController = [[InputViewController alloc] initWithWindowNibName:@"InputViewController"];
        _inputController.delegate = self;
    }
    return _inputController;
}

- (AddAppStoreAccount *)addAccount{
    if (!_addAccount) {
        _addAccount = [[AddAppStoreAccount alloc] initWithWindowNibName:@"AddAppStoreAccount"];
        _addAccount.delegate = self;
    }
    return _addAccount;
}

- (NSMutableArray *)activiteArray{
    if (!_activiteArray) {
        _activiteArray = [@[] mutableCopy];
    }
    return _activiteArray;
}

- (NSMutableArray *)customerArray{
    if (!_customerArray) {
        _customerArray = [@[] mutableCopy];
    }
    return _customerArray;
}
@end
