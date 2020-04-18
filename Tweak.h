#import <Foundation/Foundation.h>

#define PLIST_PATH "/var/mobile/Library/Preferences/com.haoict.messengernoadspref.plist"
#define PREF_CHANGED_NOTIF "com.haoict.messengernoadspref/PrefChanged"

@interface LSAppDelegate : NSObject
+ (id)sharedInstance;
- (id)getCurrentLoggedInUserId;
@end