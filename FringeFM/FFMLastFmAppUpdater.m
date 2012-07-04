//
//  FFMLastFmAppUpdater.m
//  FringeFM
//
//  Created by John Sheets on 6/10/12.
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

#import "FFMLastFmAppUpdater.h"
#import "Last.fm.h"
#import "FFMSong.h"

@implementation FFMLastFmAppUpdater

- (FFMSong *)fetchCurrentSong
{
    FFMSong *currentSong = [[FFMSong alloc] init];

    if (self.isServiceAvailable)
    {
        currentSong.isPlaying = self.isServicePlaying;

        LastApplication *lastfm = (LastApplication *)[SBApplication applicationWithBundleIdentifier:@"fm.last.Last.fm"];
        if (lastfm.trackTitle)
        {
            currentSong.track = lastfm.trackTitle;
            currentSong.artist = lastfm.artist;
            currentSong.album = lastfm.album;
            if (lastfm.artwork)
            {
                currentSong.albumImage = [[NSImage alloc] initWithData:lastfm.artwork];
            }
        }
        else
        {
            currentSong.errorText = @"Last.fm is running but nothing is playing.";
        }
    }
    else
    {
        currentSong.errorText = @"Last.fm is not running.";
    }

    return currentSong;
}

- (BOOL)isServiceAvailable
{
    return [[SBApplication applicationWithBundleIdentifier:@"fm.last.Last.fm"] isRunning];
}

- (BOOL)isServicePlaying
{
    // No way to get this via AppleScript.
    return YES;
}

@end
