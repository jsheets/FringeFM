//
//  FFMSpotifyUpdater.m
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

#import "FFMSpotifyUpdater.h"
#import "FFMSong.h"
#import "Spotify.h"

@implementation FFMSpotifyUpdater

- (id)init
{
    return [super initWithAppId:@"com.spotify.client" appName:@"Spotify"];
}

- (BOOL)loadSong:(FFMSong *)currentSong
{
    SpotifyApplication *spotify = (SpotifyApplication *)self.localApp;
    SpotifyTrack *track = spotify.currentTrack;

    BOOL foundTrack = track.name != nil;
    if (foundTrack)
    {
        currentSong.track = track.name;
        currentSong.artist = track.artist;
        currentSong.album = track.album;

        if (track.artwork)
        {
            currentSong.albumImage = track.artwork;
        }
    }

    return foundTrack;
}

- (BOOL)isServicePlaying
{
    SpotifyApplication *spotify = (SpotifyApplication *)self.localApp;
    return spotify.playerState == SpotifyEPlSPlaying;
}

@end
