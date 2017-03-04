//
//  comModel.h
//  testcomment
//
//  Created by macos on 2017/3/3.
//  Copyright © 2017年 macos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface comModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *postTime;
@property (nonatomic, copy) NSString *userIconUrl;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *commArray;

@end
