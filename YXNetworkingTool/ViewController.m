//
//  ViewController.m
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/14.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "ViewController.h"
#import "YXNetworkManager.h"
#import "JSONModel.h"
#import "CityList.h"
#import "CityHomeKey.h"
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *cityHomeKeyArr;
@property (nonatomic, strong) NSMutableArray<CityList> *cityListArr;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor orangeColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  [self test1];
}

- (void)test1{
  NSString *url = @"http://api.lanrenzhoumo.com/district/list/allcity?session_id=00004016b3e14bbea40c1aa1a14c2273a35352";
  [YXNetworkManager getRequestWithURL:url params:nil success:^(id result) {
//    NSLog(@"%@ result ++++++++++++++++++++", result);
    
    if (result) {
      NSArray * arr = result[@"result"];
      self.cityHomeKeyArr = [CityHomeKey arrayOfModelsFromDictionaries:arr error:nil];
      NSLog(@"%@",self.cityHomeKeyArr);
      CityHomeKey * key = [CityHomeKey new];
      
      // CityHomeKey 的 begin_key 数组
      NSMutableArray * beginKeyArr = [NSMutableArray array];

      for (int i = 0; i < self.cityHomeKeyArr.count; i ++) {
        key = self.cityHomeKeyArr[i];
        
        [beginKeyArr addObject:key.begin_key];
        [self.cityListArr addObject:key.city_list];
       
      }
      NSLog(@"%@",beginKeyArr);
      NSLog(@"%@",self.cityListArr);
   
    }
  } faildBlock:^(NSError *error) {
    
  }];
}

#pragma mark - getting
- (NSMutableArray *)cityHomeKeyArr{
  if (!_cityHomeKeyArr) {
    _cityHomeKeyArr = [NSMutableArray array];
  }
  return _cityHomeKeyArr;
}

- (NSMutableArray<CityList> *)cityListArr{
  if (!_cityListArr) {
    _cityListArr = [NSMutableArray<CityList> array];
  }
  return _cityListArr;
}
@end
