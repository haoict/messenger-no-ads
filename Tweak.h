#import <Foundation/Foundation.h>
#import "settingsview/MNAUtil.h"
#import "settingsview/MNASettingsViewController.h"
#import "settingsview/MNAIntroViewController.h"

@interface LSAppDelegate : NSObject
- (id)getCurrentLoggedInUserId;
+ (id)sharedInstance; // new methods
@end

@interface MSGSplitViewController : UIViewController
@property (nonatomic, retain) UIView *sideSwitch; // new property
@property (nonatomic, retain) UIImageView *imageView; // new property
- (void)initEyeButton; // new method
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

@interface LSTextView : UITextView
@end

@interface LSComposerView : NSObject
@end

@interface LSComposerComponentStackView : UIView
@end

