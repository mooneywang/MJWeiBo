//
//  MJStatusCell.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/15.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJStatusFrame;

@interface MJStatusCell : UITableViewCell

@property(nonatomic, strong)MJStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
