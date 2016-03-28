//
//  ViewController.m
//  KBTextView
//
//  Created by 梁添 on 16/3/28.
//  Copyright © 2016年 梁添. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITextViewDelegate>{
    
    UIView *kbView;
    UITextView *txtView;
    BOOL kbShowingFlag;
    CGFloat kbHeight;
    
    
    BOOL txtViewChange;
    CGFloat textViewH;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kbShowingFlag = false;
    txtViewChange = false;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self setupView];
}

- (void)setupView{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    
    UITableView *talbe = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44) style:UITableViewStylePlain];
    talbe.delegate = self;
    [self.view addSubview:talbe];
    kbView = [[UIView alloc] init];
    kbView.backgroundColor = [UIColor blueColor];
    txtView = [[UITextView alloc] init];
    txtView.delegate = self;
    [self.view addSubview:kbView];
    [kbView addSubview:txtView];
    
    
    [kbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    [txtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kbView.mas_left).offset(50);
        make.right.equalTo(kbView.mas_right).offset(-50);
        make.top.equalTo(kbView.mas_top).offset(2);
        make.bottom.equalTo(kbView.mas_bottom).offset(-2);
    }];
    
}



- (void)textViewDidChange:(UITextView *)textView{
    txtViewChange = true;
    NSLog(@"%@",NSStringFromCGSize(textView.contentSize));
    
    // 1.计算textView的高度 调整整个kbView的高度
    textViewH = 0;
    CGFloat minHeight = 44; // textview最小的高度
    CGFloat maxHeight = 68; // textview最大的高度
    
    // 获取contentsize的高度
    CGFloat contentHeight = textView.contentSize.height;
    NSLog(@"contentHeight = %f",contentHeight);
    if (contentHeight < minHeight) {
        textViewH = minHeight;
    }else if (contentHeight > maxHeight){
        textViewH = maxHeight;
    }else{
        textViewH = contentHeight;
    }
    
    // 监听return 事件
    if ([textView.text hasSuffix:@"\n"]) {
        textView.text = nil;
        textViewH = minHeight;
    }
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
}


- (void)kbWillShow:(NSNotification *)noti{
    CGRect kbEndFrm = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kbHeight = kbEndFrm.size.height;
    kbShowingFlag = true;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
}

- (void)kbWillHide:(NSNotification *)noti{
    kbShowingFlag = false;
    kbHeight = 0;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    // 键盘出现
    if (kbShowingFlag == true) {
        [kbView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(-kbHeight);
            make.height.mas_equalTo(44);
        }];
    }
    else{
        [kbView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(0);
            make.height.mas_equalTo(44);
        }];
    }
    
    // 改变textview的高度
    if (txtViewChange) {
        [kbView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(-kbHeight);
            make.height.mas_equalTo(textViewH + 4);
        }];
        [txtView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kbView.mas_left).offset(50);
            make.right.equalTo(kbView.mas_right).offset(-50);
            make.top.equalTo(kbView.mas_top).offset(2);
            make.bottom.equalTo(kbView.mas_bottom).offset(-2);
        }];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != txtView) {
        [txtView resignFirstResponder];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ||
    interfaceOrientation == UIInterfaceOrientationPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
