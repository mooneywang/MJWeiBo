//
//  MJStatusToolBar.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/18.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJStatus;

@interface MJStatusToolBar : UIView

@property(nonatomic, strong)MJStatus *status;

+ (instancetype)toolBar;

@end
