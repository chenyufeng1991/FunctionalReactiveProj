//
//  FRPGalleryFlowLayout.m
//  FunctionalReactiveDemo
//
//  Created by chenyufeng on 16/5/23.
//  Copyright © 2016年 chenyufengweb. All rights reserved.
//

#import "FRPGalleryFlowLayout.h"

@implementation FRPGalleryFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.itemSize = CGSizeMake(145, 145);
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}

@end
