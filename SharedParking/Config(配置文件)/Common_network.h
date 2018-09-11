//
//  Common_network.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/5/18.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#ifndef Common_network_h
#define Common_network_h

#warning 0:开发环境，1：正式环境， 2：测试环境
#define isTrueEnvironment 1

#warning 发布时改为0，关闭调试选项
#define isDebug 1

#warning 发布时改为1，生产环境推送
#define push_production 1

#if isTrueEnvironment == 0
#define LingBao_BASE_URL @"http://park.1mxtx.com/index/app/"

#elif isTrueEnvironment == 1
#define LingBao_BASE_URL  @"http://park.1mxtx.com/index/app/"

#else
#define LingBao_BASE_URL @"http://park.1mxtx.com/index/app/"

#endif


//http://park.1mxtx.com/index/index/set_qrcode/parking_id/3

#define Img_Url @"http://park.1mxtx.com"

#endif /* Common_network_h */
