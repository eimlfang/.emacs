//
//  NSString+Category.h
//  Ezdiary
//
//  Created by Besprout's Mac Mini on 15/12/14.
//  Copyright © 2015年 Fang Zijian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NStrFromCPP(cppstr) [[NSString alloc] initWithCString:cppstr.c_str() encoding:NSUTF8StringEncoding]

@interface NSString (Category)

@end
