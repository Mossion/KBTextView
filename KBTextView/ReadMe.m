//
//  ReadMe.m
//  Test
//
//  Created by 梁添 on 16/3/28.
//  Copyright © 2016年 梁添. All rights reserved.
//

//
/** 
 Masonry 约束键盘弹起并做成短信输入框的效果，滚动tableview键盘回收，类似QQ
 1. 键盘出现时,kbView随着键盘弹起  做一个全部变量 BOOL kbShowingFlag
    当键盘出现的时候强行修改约束，
     [self.view setNeedsUpdateConstraints];
     [self.view updateConstraintsIfNeeded];
     [UIView animateWithDuration:0.25 animations:^{
     [self.view layoutIfNeeded];
     }];
    重写- (void)updateViewConstraints 方法
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
     }
 
  2.textview换行动态改变kbView的高度  BOOL txtViewChange 是否textView发生变化
    监听textView的 - (void)textViewDidChange:(UITextView *)textView 代理方法
    获取textView的contentSize
     CGFloat contentHeight = textView.contentSize.height;
    高度发生变化时强制修改约束
     [self.view setNeedsUpdateConstraints];
     [self.view updateConstraintsIfNeeded];
     // 为了有动画效果
     [UIView animateWithDuration:0.25 animations:^{
         [self.view layoutIfNeeded];
     }];
 
 
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
             make.left.equalTo(kbView.mas_left).offset(150);
             make.right.equalTo(kbView.mas_right).offset(-150);
             make.top.equalTo(kbView.mas_top).offset(2);
             make.bottom.equalTo(kbView.mas_bottom).offset(-2);
         }];
         }
     
     }
 */

