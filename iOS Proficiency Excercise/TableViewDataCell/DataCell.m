//
//  DataCell.m
//  iOS Proficiency Excercise
//
//  Created by Sanjeet on 1/11/17.
//  Copyright © 2017 Sanjeet. All rights reserved.
//

#import "DataCell.h"

@implementation DataCell
@synthesize lableTitle,lableDescription,imageProfile;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView setFrame:CGRectMake(0, 0, 320, 103)];
        
        // Initialization code
        lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
        lableTitle.textAlignment = NSTextAlignmentLeft;
        lableTitle.font = [UIFont boldSystemFontOfSize:17];
        
        lableDescription = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 210, 18)];
        lableDescription.textAlignment = NSTextAlignmentLeft;
        lableDescription.font = [UIFont systemFontOfSize:15];
        lableDescription.lineBreakMode = NSLineBreakByWordWrapping;
        lableDescription.numberOfLines = 0;
        
        imageProfile = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder"]];
        imageProfile.frame = CGRectMake(225, 35, 85, 57);
        imageProfile.clipsToBounds = YES;
        [imageProfile setContentMode:UIViewContentModeScaleAspectFill];
        
        [self.contentView addSubview:lableTitle];
        [self.contentView addSubview:lableDescription];
        [self.contentView addSubview:imageProfile];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark set constraints of lables & images

- (void)setupCellUIConstraints
{
    [lableTitle removeConstraints:lableTitle.constraints];
    [lableDescription removeConstraints:lableDescription.constraints];
    [imageProfile removeConstraints:imageProfile.constraints];
    [self.contentView removeConstraints:self.contentView.constraints];
    
    [self setTitleLableConstraints];
    [self setDescriptionLableConstraints];
    [self setImageViewConstraints];
}

- (void)setTitleLableConstraints
{
    [lableTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // align self.lableTitle from the left and right
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[lableTitle]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(lableTitle)]];
    
    // align self.lableTitle from the top
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lableTitle]-5-[lableDescription]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(lableTitle, lableDescription)]];
    
    // align self.lableTitle from the top
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lableTitle]-5-[imageProfile]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(lableTitle, imageProfile)]];
}

- (void)setDescriptionLableConstraints
{
    [lableDescription setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // align self.lableDescription from the left
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[lableDescription]-5-[imageProfile]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(lableDescription, imageProfile)]];
    

}

- (void)setImageViewConstraints
{
    [imageProfile setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    // align self.imageProfile from width constraint
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageProfile(==85)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(imageProfile)]];
    
    // height constraint
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageProfile(==57)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(imageProfile)]];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
