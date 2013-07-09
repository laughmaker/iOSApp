//
//  NSString+Trim.m
//  AlertsDemo
//
//  Created by M B. Bitar on 1/15/13.
//  Copyright (c) 2013 progenius, inc. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

-(NSString*)stringByTruncatingToSize:(CGSize)size withFont:(UIFont*)font addQuotes:(BOOL)addQuotes
{
    int min = 0, max = self.length, mid;
    while (min < max) {
        mid = (min+max)/2;
        
        NSString *currentString = [self substringWithRange:[self rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, mid)]];
        CGSize currentSize = [currentString sizeWithFont:font constrainedToSize:CGSizeMake(size.width, MAXFLOAT)];
        currentString = nil;
        
        if (currentSize.height < size.height){
            min = mid + 1;
        } else if (currentSize.height > size.height) {
            max = mid - 1;
        } else {
            min = mid;
            break;
        }
    }
    /* handle emoji */
    NSMutableString *finalString = [[self substringWithRange:[self rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, min)]] mutableCopy];
    int length = addQuotes ? 4 : 3;
    NSString *appendString = addQuotes ? @"...\"" : @"...";
    if(finalString.length < self.length && finalString.length > length) {
        [finalString replaceCharactersInRange:[finalString rangeOfComposedCharacterSequencesForRange:NSMakeRange(finalString.length - length, length)] withString:appendString];
    }
    return finalString;
}

@end
