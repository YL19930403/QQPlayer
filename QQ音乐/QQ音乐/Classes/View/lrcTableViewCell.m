//
//  lrcTableViewCell.m
//  QQ音乐
//
//  Created by 余亮 on 16/2/28.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "lrcTableViewCell.h"

@implementation lrcTableViewCell

- (void)awakeFromNib {

}

+ (instancetype) irlCellWithTableView:(UITableView *)tableView {
    static NSString * ID = @"lrcTableViewCell";
    lrcTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[lrcTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return cell ;
    
}

@end
