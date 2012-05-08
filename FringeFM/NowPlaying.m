//
//  NowPlaying.m
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

#import "NowPlaying.h"

@implementation NowPlaying

@synthesize isPlaying = _isPlaying;
@synthesize artist = _artist;
@synthesize album = _album;
@synthesize track = _track;
@synthesize artSmallUrl = _artSmallUrl;
@synthesize error = _error;

- (id)initWithJson:(NSString *)json
{
    if ((self = [super initWithJson:json]))
    {
        // Check for error: {"error":8,"message":"Error fetching recent tracks"}
        if ([self valueForProperty:@"error"])
        {
            self.error = [self valueForProperty:@"message"];
        }

        // Assign nowPlaying property.
        NSString *nowPlayingValue = [self valueForProperty:@"recenttracks.track[0].@attr.nowplaying"];
        self.isPlaying = [nowPlayingValue isEqualToString:@"true"];

        self.artist = [self valueForProperty:@"recenttracks.track[0].artist.#text"];
        self.album = [self valueForProperty:@"recenttracks.track[0].album.#text"];
        self.track = [self valueForProperty:@"recenttracks.track[0].name"];

        NSArray *images = [self valueForProperty:@"recenttracks.track[0].image"];
        for (NSDictionary *imageDict in images)
        {
            if ([[imageDict valueForKey:@"size"] isEqualToString:@"small"])
            {
                NSString *urlString = [imageDict valueForKey:@"#text"];
                if ([urlString length])
                {
                    self.artSmallUrl = [NSURL URLWithString:urlString];
                }

                break;
            }
        }
    }

    return self;
}

@end
