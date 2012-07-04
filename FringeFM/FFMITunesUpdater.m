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

- (id)init
{
    return [super initWithAppId:@"com.apple.iTunes" appName:@"iTunes"];
}

- (BOOL)loadSong:(FFMSong *)currentSong
{
    iTunesApplication *iTunes = (iTunesApplication *)self.localApp;
    iTunesTrack *track = iTunes.currentTrack;

    BOOL foundTrack = [track exists];
    if (foundTrack)
    {
        currentSong.track = track.name;
        currentSong.artist = track.artist;
        currentSong.album = track.album;
        currentSong.isPlaying = self.isServicePlaying;

        iTunesArtwork *artwork = (iTunesArtwork *)[[[track artworks] get] lastObject];
        if (artwork)
        {
            currentSong.albumImage = [[NSImage alloc] initWithData:[artwork rawData]];
        }
    }

    return foundTrack;
}

- (BOOL)isServicePlaying
{
    iTunesApplication *iTunes = (iTunesApplication *)self.localApp;
    return iTunes.playerState == iTunesEPlSPlaying;
}

@end
