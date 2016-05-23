//
//  FRPPhotoImporter.m
//  FunctionalReactiveDemo
//
//  Created by chenyufeng on 16/5/23.
//  Copyright © 2016年 chenyufengweb. All rights reserved.
//

#import "FRPPhotoImporter.h"
#import "FRPPhotoModel.h"

@implementation FRPPhotoImporter

+ (RACReplaySubject *)importPhotos
{
    RACReplaySubject *subject = [RACReplaySubject subject];
    NSURLRequest *request = [self popularURLRequest];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                               if (data)
                               {
                                   id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   [subject sendNext:[[[result[@"photos"] rac_sequence]
                                                 map:^id(NSDictionary *photoDictionary) {
                                                     FRPPhotoModel *model = [FRPPhotoModel new];
                                                     [self configurePhotoModel:model withDictionary:photoDictionary];
//                                                     [self downloadThumbnailForPhotoModel:model];
                                                     return model;
                                   }] array]];
                                   [subject sendCompleted];
                               }
                               else
                               {
                                   [subject sendError:connectionError];
                               }
                           }];
    return subject;
}

+ (NSURLRequest *)popularURLRequest
{
    return [MyAppDelegate.apiHelper urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular
                                               resultsPerPage:100
                                                         page:0
                                                   photoSizes:PXPhotoModelSizeThumbnail
                                                    sortOrder:PXAPIHelperSortOrderRating
                                                       except:PXPhotoModelCategoryNude];
}

+ (void)configurePhotoModel:(FRPPhotoModel *)photoModel withDictionary:(NSDictionary *)dictionary
{
    photoModel.photoName = dictionary[@"name"];
    photoModel.identifier = dictionary[@"id"];
    photoModel.photographerName = dictionary[@"user"][@"username"];
    photoModel.rating = dictionary[@"rating"];

    photoModel.thumbnailURL = [self urlForImageSize:3 inArray:dictionary[@"images"]];

    if (dictionary[@"comments_count"])
    {
//        photoModel.fullsizedURL = [self ]
    }
}

+ (NSString *)urlForImageSize:(NSInteger)size inArray:(NSArray *)array
{
    return [[[[[array rac_sequence]
             filter:^BOOL(NSDictionary *value) {
                 return [value[@"size"] integerValue] == size;
             }]
                map:^id(id value) {
                    return value[@"url"];
            }] array] firstObject];
}

+ (void)downloadThumbnailForPhotoModel:(FRPPhotoModel *)photoModel
{
    NSAssert(photoModel.thumbnailURL, @"Thumbnail URL must not be nil");
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:photoModel.thumbnailURL]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                               photoModel.thumbnailData = data;
                           }];
}

@end










