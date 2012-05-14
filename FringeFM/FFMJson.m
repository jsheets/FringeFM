//
//  FMJson.m
//  SkronkFM
//
//  Created by John Sheets on 2/4/12.
//  Copyright (c) 2012 John Sheets. All rights reserved.
//
// MIT License
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "FFMJson.h"

@implementation FFMJson

@synthesize jsonText = _jsonText;
@synthesize jsonObject = _jsonObject;

- (id)initWithJson:(NSString *)jsonText
{
    if ((self = [super init]))
    {
        _jsonText = jsonText;

        NSError *error = nil;
        NSData *jsonData = [jsonText dataUsingEncoding:NSUTF8StringEncoding];
        self.jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    }

    return self;
}

- (NSInteger)arrayIndex:(NSString *)keyPath
{
    NSInteger index = NSNotFound;

    NSUInteger leftBrace = [keyPath rangeOfString:@"["].location;
    NSUInteger rightBrace = [keyPath rangeOfString:@"]"].location;
    if (leftBrace != NSNotFound && rightBrace != NSNotFound && leftBrace < rightBrace)
    {
        NSString *indexString = [keyPath substringWithRange:NSMakeRange(leftBrace + 1, 1)];
        index = [indexString integerValue];
    }

    return index;
}

- (NSString *)basePathPart:(NSString *)keyPath
{
    NSString *baseKey = keyPath;

    // Strip off left brace and everything after.
    NSUInteger leftBrace = [keyPath rangeOfString:@"["].location;
    if (leftBrace != NSNotFound)
    {
        baseKey = [keyPath substringToIndex:leftBrace];
    }

    return baseKey;
}

// keyPath is a blend of KVO and XPath (KVO with array accessors), but that allows properties
// such as "@attr" and "#text".
- (id)valueForProperty:(NSString *)keyPath
{
    id currentObject = self.jsonObject;
    NSArray *pathParts = [keyPath componentsSeparatedByString:@"."];

    for (NSString *pathPart in pathParts)
    {
        // Check for array element.
        NSInteger index = [self arrayIndex:pathPart];
        if (index != NSNotFound)
        {
            // Path part is an array. Update currentObject to point to the
            // Requested array element.
            NSString *basePathPart = [self basePathPart:pathPart];
            NSArray *array = [currentObject objectForKey:basePathPart];
            currentObject = [array objectAtIndex:index];
        }
        else
        {
            currentObject = [currentObject objectForKey:pathPart];
        }
    }

    return currentObject;
}

@end
