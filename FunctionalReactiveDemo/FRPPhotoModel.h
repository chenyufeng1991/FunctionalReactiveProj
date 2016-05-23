//
//  FRPPhotoModel.h
//  FunctionalReactiveDemo
//
//  Created by chenyufeng on 16/5/23.
//  Copyright © 2016年 chenyufengweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRPPhotoModel : NSObject

@property(nonatomic, strong) NSString *photoName;
@property(nonatomic, strong) NSNumber *identifier;
@property(nonatomic, strong) NSString *photographerName;
@property(nonatomic, strong) NSNumber *rating;
@property(nonatomic, strong) NSString *thumbnailURL;
@property(nonatomic, strong) NSData *thumbnailData;
@property(nonatomic, strong) NSString *fullsizedURL;
@property(nonatomic, strong) NSData *fullsizedData;

@end
