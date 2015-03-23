//
//  CXUser.h
//  CXWeibo
//
//  Created by gaocaixin on 15-3-15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXUser : NSObject
/**作者名字*/
@property (nonatomic, copy) NSString *name;
/**头像url*/
@property (nonatomic, copy) NSString *profile_image_url;
/**作者*/
@property (nonatomic, copy) NSString *idstr;
/**vip*/
@property (nonatomic, assign) int mbtype;
@property (nonatomic, assign) int mbrank;

//+ (instancetype)userWithDict:(NSDictionary *)dict;
//- (instancetype)initWithDict:(NSDictionary *)dict;



@end
