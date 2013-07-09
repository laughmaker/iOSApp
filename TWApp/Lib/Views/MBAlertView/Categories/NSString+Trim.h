//
//  NSString+Trim.h
//  AlertsDemo
//
//  Created by M B. Bitar on 1/15/13.
//  Copyright (c) 2013 progenius, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trim)
-(NSString*)stringByTruncatingToSize:(CGSize)size withFont:(UIFont*)font addQuotes:(BOOL)addQuotes;
@end
