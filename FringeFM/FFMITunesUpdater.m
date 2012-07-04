//
//  FFMITunesUpdater.m
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

#import "FFMITunesUpdater.h"
#import "FFMSong.h"
#import "iTunes.h"

@implementation FFMITunesUpdater

- (FFMSong *)fetchCurrentSong
{
    FFMSong *currentSong = [[FFMSong alloc] init];
    
    if (self.isServiceAvailable)
    {
        iTunesApplication *iTunes = (iTunesApplication *)[SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
        iTunesTrack *track = iTunes.currentTrack;
        if ([track exists])
        {
            currentSong.track = track.name;
            currentSong.artist = track.artist;
            currentSong.album = track.album;
        }
        else
        {
            currentSong.errorText = @"iTunes is running but nothing is playing.";
        }
    }
    else
    {
        currentSong.errorText = @"iTunes is not running.";
    }

    return currentSong;
}

- (BOOL)isServiceAvailable
{
    return [[SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"] isRunning];
}

- (BOOL)isServicePlaying
{
    iTunesApplication *iTunes = (iTunesApplication *)[SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    return iTunes.playerState == iTunesEPlSPlaying;
}

@end
