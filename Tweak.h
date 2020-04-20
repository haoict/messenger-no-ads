#import <Foundation/Foundation.h>

#define PLIST_PATH "/var/mobile/Library/Preferences/com.haoict.messengernoadspref.plist"
#define PREF_CHANGED_NOTIF "com.haoict.messengernoadspref/PrefChanged"

@interface LSAppDelegate : NSObject
+ (id)sharedInstance;
- (id)getCurrentLoggedInUserId;
@end

@interface MBUIStoryViewerAuthorOverlayModel : UIView
@property(readonly, copy, nonatomic) NSString *authorId;
@end

@interface LSMediaViewController : UIViewController
- (void)saveMedia;
@end

@interface LSStoryBucketViewControllerBase : UIViewController
@property(readonly, nonatomic) LSMediaViewController *currentThreadVC;
- (void)_pauseProgressIndicatorWithReset:(BOOL)arg1;
- (void)startTimer;
@end

@interface LSStoryBucketViewController : LSStoryBucketViewControllerBase
@end

@interface LSStoryOverlayViewController : UIViewController
@property(nonatomic, weak, readwrite) LSStoryBucketViewController * parentViewController;
@end

@interface LSStoryOverlayProfileView : UIView
@property(nonatomic) LSStoryOverlayViewController * delegate;
@end
