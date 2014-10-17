//
//  MAActionCollectionViewCell.m
//  Mama
//
//  Created by Kevin Nguy on 8/14/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "MAActionCollectionViewCell.h"

@implementation MAActionCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.button.layer.borderWidth = 2;
        self.button.layer.cornerRadius = CGRectGetWidth(self.button.frame) / 2;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
