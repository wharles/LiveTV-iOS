//
//  GlobalMacro.h
//  LiveTV
//
//  Created by Charlies Wang on 15/12/19.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#ifndef GlobalMacro_h
#define GlobalMacro_h

/**
 API接口
 **/
#define APIKEY @"f351515304020cad28c92f70f002261c"
#define CHANNELAPI(size, page, cid, timestamp) [NSString stringWithFormat:@"http://api.tv.sohu.com/v4/search/channel.json?page_size=%ld&page=%ld&o=-1&cid=%ld&api_key=%@&plat=17&sver=1.0&partner=1&cat=&area=&year=&_=%ld", (long)size, (long)page,(long)cid, APIKEY, (long)timestamp]

#define VIDEOAPI(aid, timestamp) [NSString stringWithFormat:@"http://api.tv.sohu.com/v4/album/videos/%ld.json?page_size=800&with_trailer=1&site=1&order=1&_cb=&api_key=%@&plat=17&sver=1.0&partner=1&_=%ld",(long)aid, APIKEY, (long)timestamp]

#define SEARCHAPI(key, page, size) [NSString stringWithFormat:@"http://api.tv.sohu.com/v4/search/all.json?key=%@&cid=-1&uid=A170EF912374547915E9FFE0CF6C31D8&pay=1&page=%ld&page_size=%ld&api_key=%@&plat=11&sver=3.6.0&partner=319", key, (long)page, (long)size, APIKEY]

#define DOWNLOADSTRING @"&uid=A170EF912374547915E9FFE0CF6C31D8&pt=8&prod=app&pg=1"

/**
 APP配色
 **/
#define SPLITLINECOLOR @"#E5E5E5"
#define BARTINTCOLOR @"#E75F35"
#define BUTTONTINTCOLOR @"#EB491B"
#define TOOLBARTINTCOLOR @"#EDF0F3"
#define TABBARTINTCOLOR @"#EB4B1B"
#define TABBARBARTINTCOLOR @"#000000"
#define SELECTEDCOLOR @"#F8F8F8"
#define MAINCOLOR [UIColor whiteColor]
#define MAINFONTCOLOR [UIColor grayColor];

#endif /* GlobalMacro_h */
