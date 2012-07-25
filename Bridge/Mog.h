/*
 * Mog.h
 */

#import <AppKit/AppKit.h>
#import <ScriptingBridge/ScriptingBridge.h>


@class MogApplication;



/*
 * MOG Airfoil Integration Suite
 */

// The application's top-level scripting object.
@interface MogApplication : SBApplication

@property (copy, readonly) NSString *title;  // Title of currently playing track.
@property (copy, readonly) NSString *artist;  // Artist of currently playing track.
@property (copy, readonly) NSString *album;  // Album of currently playing track.
@property (readonly) NSInteger duration;  // Duration of currently playing track.
@property (copy, readonly) NSData *artwork;  // Artwork for the currently playing track.

- (void) playpause;  // Toggle playback between playing and paused.
- (void) pause;  // Pause playback
- (void) next;  // Play the next track.
- (void) previous;  // Play the previous track.

@end

