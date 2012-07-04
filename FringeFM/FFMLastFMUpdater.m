//
//  FFMLastFMUpdater.m
//  FringeFM
//
//  Created by John Sheets on 5/14/12.
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

#import "FFMSong.h"
#import "FFMLastFmJson.h"
#import "FFMLastFMUpdater.h"
#import "ASIHTTPRequest.h"

@implementation FFMLastFMUpdater

@synthesize userName = _userName;

- (id)initWithUserName:(NSString *)userName apiKey:(NSString *)apiKey
{
    if ((self = [super initWithAppId:apiKey appName:@"Last.fm API"]))
    {
        // Initialization.
        self.userName = userName;
        self.updateFrequency = 15;
    }

    return self;
}

// Fetch the currently playing song from the last.fm web REST API. Synchronous?
- (FFMSong *)fetchCurrentSong
{
    FFMSong *currentSong = nil;

    NSString *urlString = [NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&api_key=%@&limit=2&user=%@&format=json", self.appId, self.userName];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"Looking up last.fm URL: %@", url);

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];

    NSError *error = [request error];
    if (error == nil)
    {
        // Success
        // Completed the HTTP request from last.fm. Now load the JSON response into a FFMSong object.
        NSString *responseString = [request responseString];
//        NSLog(@"Received JSON: %@", responseString);

        FFMLastFmJson *currentlyPlaying = [[FFMLastFmJson alloc] initWithJson:responseString];
        currentSong = currentlyPlaying.song;

        // Attach wrapper JSON object to the song in case we need it later (we will).
        currentSong.source = currentlyPlaying;
    }
    else
    {
        // Error
        NSString *errString = [NSString stringWithFormat:@"Error updating last.fm status: %@", [error localizedDescription]];
        NSLog(@"%@", errString);

        // Create an empty song object to return the error string in. Essentially a null object.
        currentSong = [[FFMSong alloc] init];
        currentSong.errorText = [NSString stringWithFormat:@"last.fm Error: %@", errString];
    }

    return currentSong;
}

- (BOOL)isServicePlaying
{
    return YES;
}

- (BOOL)isServiceRemote
{
    return YES;
}

@end
