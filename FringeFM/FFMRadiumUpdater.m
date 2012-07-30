//
//  FFMRadiumUpdater.m
//  FringeFM
//
//  Created by John Sheets on 7/30/12.
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

#import "FFMRadiumUpdater.h"
#import "FFMSong.h"
#import "Radium.h"

@implementation FFMRadiumUpdater

- (id)init
{
    return [super initWithAppId:@"com.catpigstudios.Radium" appName:@"Radium"];
}

- (BOOL)loadSong:(FFMSong *)currentSong
{
    RadiumApplication *radium = (RadiumApplication *)self.localApp;
    RadiumRplayer *player = radium.player;
    BOOL foundTrack = player.songTitle != nil;
    if (foundTrack)
    {
        NSString *songTitle = player.songTitle;
        NSArray *songParts = [songTitle componentsSeparatedByString:@" - "];
        if ([songParts count] > 1)
        {
            // Split apart "Artist - Song".
            currentSong.artist = [songParts objectAtIndex:0];
            currentSong.track = [songParts objectAtIndex:1];
        }
        else
        {
            // Not "Artist - Song" format, so put everything in the Track.
            currentSong.track = songTitle;
        }

        currentSong.album = player.networkName;
        
        if (player.songArtwork)
        {
            currentSong.albumImage = (NSImage *)player.songArtwork;
        }
    }

    return foundTrack;
}

- (BOOL)isServicePlaying
{
    RadiumApplication *radium = (RadiumApplication *)self.localApp;
    RadiumRplayer *player = radium.player;
    return player.playing;
}

@end
