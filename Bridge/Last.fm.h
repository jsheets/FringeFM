/*
 * Last.h
 */

#import <AppKit/AppKit.h>
#import <ScriptingBridge/ScriptingBridge.h>


@class LastFmApplication;



/*
 * Last.fm Suite
 */

// The application's top-level scripting object.
@interface LastFmApplication : SBApplication

@property (copy, readonly) NSString *trackTitle;  // Title of currently playing track.
@property (copy, readonly) NSString *artist;  // Artist of currently playing track.
@property (copy, readonly) NSString *album;  // Album of currently playing track.
@property (readonly) NSInteger duration;  // Duration of currently playing track.
@property (readonly) BOOL loved;  // The loved status of currently playing track.
@property (copy, readonly) NSData *artwork;  // Artwork for the currently playing track.

- (void) playpause;  // Toggle playback between playing and paused.
- (void) next;  // Play the next track.
- (void) previous;  // Play the previous track.
- (void) love;  // Love the current track.
- (void) ban;  // Ban the current track.

@end

