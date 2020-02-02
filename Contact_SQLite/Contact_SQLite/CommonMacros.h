//
//  CommonMacros.h
//  Contact_SQLite
//
//  Created by LAP12852 on 2/1/20.
//  Copyright © 2020 LAP12852. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h

#if DEBUG
#define DEBUG_LOG(arguments, ...)  NSLog(@"%s(%d): " arguments, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else // DEBUG
#define DEBUG_LOG {}
#endif // DEBUG

#define AssertNonNull(obj) NSAssert(obj != nil, @"Argument " @#obj " must be non null")

#define IS_NON_EMPTY_STRING(str) (str != nil && [str isKindOfClass:[NSString class]] && str.length > 0)

#define IS_EMPTY_STRING(str) !(IS_NON_EMPTY_STRING(str))

#endif /* CommonMacros_h */
