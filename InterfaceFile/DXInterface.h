//
//  DXInterface.h
//  DaxuejiaoStudent
//
//  Created by miaofangwang on 15/8/26.
//  Copyright (c) 2015年 zilujiaoyu. All rights reserved.
//

#ifndef DaxuejiaoStudent_DXInterface_h
#define DaxuejiaoStudent_DXInterface_h

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]

#define DXNOTIFICATION_LOGINCHANGE @"DXLoginStateChange"
#define DXLOGINMOBILE @"DXLoginMobile"

#endif
