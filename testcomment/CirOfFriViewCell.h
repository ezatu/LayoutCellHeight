//
//  CirOfFriViewCell.h
//  testcomment
//
//  Created by macos on 2017/3/3.
//  Copyright © 2017年 macos. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBack)(NSString *comment);

@class comModel;

@interface CirOfFriViewCell : UITableViewCell

@property (nonatomic, copy) CallBack commentBlock;
@property (nonatomic, strong) comModel *model;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) UITextField *comField;


- (void)postCommentWithCallBack:(CallBack)block;

@end
