//
//  CityList.h
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/17.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "JSONModel.h"

@protocol  CityList<NSObject>
@end

@interface CityList : JSONModel
@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *province_id;
@property (nonatomic, copy) NSString *province_name;

@end
