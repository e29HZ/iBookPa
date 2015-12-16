//
//  BPStatus.m
//  iBookPa
//
//  Created by X140Yu on 7/8/15.
//  Copyright (c) 2015 X140Yu. All rights reserved.
//

#import "BPStatus.h"
#import "BPUser.h"

@implementation BPStatus
InitM(status);

+ (NSArray *)status {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"home.plist" ofType:nil]];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self statusWithDict:dict]];
    }
    
    return arrayM;
}


+ (NSString *)statusCategoryNameStringWithStatusCategory:(BPStatusCategory)category {
    NSString *str = [NSString stringWithFormat:@"%d", category];
    NSDictionary *dict = @{@"0" : @"陪读书",
                           @"1" : @"去自习",
                           @"2" : @"找书友",
                           @"3" : @"换本书",
                           @"4" : @"求教材",
                           @"5" : @"求补课"};
    return dict[str];
}



@end
