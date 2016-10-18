//
//  CityHomeKey.h
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/17.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "JSONModel.h"
#import "CityList.h"

@interface CityHomeKey : JSONModel
@property (nonatomic, copy) NSString *begin_key;
@property (nonatomic, copy) NSArray<CityList>*city_list;

@end
