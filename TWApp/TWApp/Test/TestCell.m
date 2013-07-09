//
//  TestCell.m
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    { }
    return self;
}

- (void)awakeFromNib
{
    [self defaultInit];
}

- (void)defaultInit
{
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    [self.nicknameLbl setFont:kTitleFont1];
    [self.nicknameLbl setTextColor:kContentHighlightColor];
    [self.contentLbl setFont:kContentFont];
    [self.thumbnail setBackgroundColor:[UIColor brownColor]];
}

- (void)configureCellWithCellDatas:(id)cellDatas
{
    [super configureCellWithCellDatas:cellDatas];
    [self.nicknameLbl setText:cellDatas[@"nickname"]];
    
    self.contentLbl.height = [[self class] heightForContent:cellDatas[@"content"]];
    [self.contentLbl setText:cellDatas[@"content"]];

    NSString *portraintUrl = [NSString stringWithFormat:@"%@%@", kImagePrex, cellDatas[@"avatar"]];
    [self.thumbnail setImageWithURL:[NSURL URLWithString:portraintUrl]];
}

+ (CGFloat)heightForContent:(NSString *)content
{
    CGSize contrainSize = CGSizeMake(200, 1500);
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = [content sizeWithFont:font constrainedToSize:contrainSize];
    return size.height;
}

+ (CGFloat)cellHeightForCellDatas:(NSDictionary *)cellDatas
{
    CGFloat contentHeight = [self.class heightForContent:cellDatas[@"content"]];
    if (contentHeight < 40)
        return 90;

    return contentHeight + 30;
}


@end
