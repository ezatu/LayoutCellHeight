//
//  CirOfFriViewCell.m
//  testcomment
//
//  Created by macos on 2017/3/3.
//  Copyright © 2017年 macos. All rights reserved.
//

#import "CirOfFriViewCell.h"
#import <Masonry/Masonry.h>
#import "UIImageView+WebCache.h"
#import "comModel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define MARGIN 10
#define picWidth (SCREEN_WIDTH - 4 * MARGIN) / 3

@interface CirOfFriViewCell () {

    UIImageView *_iconView;  // 用户头像
    UILabel *_nameLabel;  // 用户昵称
    UILabel *_timeLabel;  // 发布时间
    UILabel *_contentLabel;  // 发布内容
    UIView *_imgViews;  // 发布图片容器view
    UIView *_comViews;  // 评论显示容器view
    UITextField *_comField; // 评论输入框
    
}

@end

@implementation CirOfFriViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (CGFloat)cellHeight {

    return CGRectGetMaxY(_comField.frame);
    
}

- (void)setModel:(comModel *)model {
    _model = model;
    for (UIView *view in _imgViews.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in _comViews.subviews) {
        [view removeFromSuperview];
    }
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.userIconUrl]];
    _nameLabel.text = model.userName;
    _timeLabel.text = model.postTime;
    _contentLabel.text = model.content;
    [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(MARGIN);
        make.left.equalTo(_iconView.mas_right).offset(MARGIN);
        make.right.equalTo(self.contentView).offset(-MARGIN);
        make.height.mas_equalTo([self onGetFontsSizeWithText:model.content].height + MARGIN * 2);
    }];
    
    // 布局图片
    for (NSInteger i = 0; i < model.imgArray.count; i ++) {
        NSInteger row = i / 3;
        NSInteger column = i % 3;
        UIImageView *picView = [[UIImageView alloc] init];
        [_imgViews addSubview:picView];
        [picView sd_setImageWithURL:[NSURL URLWithString:model.imgArray[i]]];
        [picView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(picWidth, picWidth));
            make.left.equalTo(_imgViews).offset(column * (MARGIN + picWidth) + MARGIN);
            make.top.equalTo(_imgViews).offset(row * (MARGIN + picWidth) + MARGIN);
        }];
        picView.layer.borderWidth = 0.2;
        picView.layer.borderColor = [UIColor grayColor].CGColor;
    }
    [_imgViews mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom).offset(MARGIN);
        make.width.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        if (model.imgArray.count <= 3) {
            make.height.mas_equalTo(MARGIN * 2 + picWidth);
        } else {
            make.height.mas_equalTo(2 * (MARGIN + picWidth) + MARGIN);
        }
    }];
    
    
    // 布局评论
    for (NSInteger i = 0; i < model.commArray.count; i ++) {
        UILabel *commLabel = [[UILabel alloc] init];
        commLabel.text = model.commArray[i];
        commLabel.font = [UIFont systemFontOfSize:12];
        commLabel.textColor = [UIColor whiteColor];
        [_comViews addSubview:commLabel];
        [commLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@25);
            make.left.equalTo(_comViews);
            make.top.equalTo(_comViews).offset(5 + (5 + 25) * i);
        }];
        commLabel.backgroundColor = [UIColor blackColor];
    }
    [_comViews mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgViews.mas_bottom).offset(MARGIN);
        make.left.equalTo(self.contentView).offset(MARGIN);
        make.height.mas_equalTo(model.commArray.count * (25 + 5) + 5);
        make.right.equalTo(self.contentView).offset(-MARGIN);
    }];
    
    [self layoutIfNeeded];
    
}

- (CGSize)onGetFontsSizeWithText:(NSString *)text {
    return [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30 - 45, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 用户头像
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(MARGIN);
            make.top.equalTo(self.contentView).offset(MARGIN);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        _iconView.layer.cornerRadius = 22.5;
        _iconView.layer.masksToBounds = YES;
        
        // 用户昵称
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconView);
            make.left.equalTo(_iconView.mas_right).offset(MARGIN);
        }];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        
        // 发布时间
        _timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-MARGIN);
            make.top.equalTo(_nameLabel);
        }];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor grayColor];

        
        // 发布内容
        _contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).offset(MARGIN);
            make.left.equalTo(_iconView.mas_right).offset(MARGIN);
            make.right.equalTo(self.contentView).offset(-MARGIN);
        }];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;

        
        // 发布图片容器
        _imgViews = [[UIView alloc] init];
        [self.contentView addSubview:_imgViews];
        [_imgViews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.mas_bottom).offset(MARGIN);
            make.width.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            make.height.equalTo(@45);
        }];
        
        // 评论显示容器view
        _comViews = [[UIView alloc] init];
        [self.contentView addSubview:_comViews];
        [_comViews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgViews.mas_bottom).offset(MARGIN);
            make.height.equalTo(@45);
            make.left.equalTo(self.contentView).offset(MARGIN);
            make.right.equalTo(self.contentView).offset(-MARGIN);
        }];
        
        // 评论框
        _comField = [[UITextField alloc] init];
        [self.contentView addSubview:_comField];
        [_comField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_comViews.mas_bottom);
            make.width.equalTo(self.contentView);
            make.height.equalTo(@35);
        }];
        _comField.backgroundColor = [UIColor orangeColor];
        _comField.font = [UIFont systemFontOfSize:14];
        _comField.placeholder = @"请输入评论内容";
        _comField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _comField.leftViewMode = UITextFieldViewModeAlways;
        UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [postBtn setTitle:@"发布" forState:UIControlStateNormal];
        postBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [postBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        postBtn.frame = CGRectMake(0, 0, 35, 35);
        [postBtn addTarget:self action:@selector(handlePostBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        _comField.rightView = postBtn;
        _comField.rightViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (void)postCommentWithCallBack:(CallBack)block {
    self.commentBlock = block;
}

- (void)handlePostBtnClickAction:(UIButton *)sender {
    self.commentBlock(_comField.text);
    _comField.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
