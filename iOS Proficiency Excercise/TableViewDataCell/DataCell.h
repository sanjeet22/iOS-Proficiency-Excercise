//
//  DataCell.h
//  iOS Proficiency Excercise
//
//  Created by Sanjeet on 1/11/17.
//  Copyright © 2017 Sanjeet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataCell : UITableViewCell
{
 
}

@property (strong, nonatomic) UILabel *lableTitle;
@property (strong, nonatomic) UILabel *lableDescription;
@property (strong, nonatomic) UIImageView *imageProfile;

- (void)setupCellUIConstraints;
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier;
@end
