#include <dlfcn.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <libhdev/HUtilities/HCommon.h>
#import "settingsview/MNASettingsViewController.h"
#import "settingsview/MNAIntroViewController.h"

@interface LSAppDelegate : NSObject
+ (id)sharedInstance; // new methods
- (id)getCurrentLoggedInUserId;
- (void)presentViewController:(id)arg1 animated:(BOOL)arg2 completion:(id)arg3;
@end

@interface MSGSplitViewController : UIViewController
@property (nonatomic, retain) UIView *sideSwitch; // new property
@property (nonatomic, retain) UIImageView *imageView; // new property
- (void)initEyeButton; // new method
@end

@interface MDSSplitViewController : UIViewController
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
@property(readonly, copy, nonatomic) NSString *storyAuthorId;
@end

@interface LSTextView : UITextView
@end

@interface LSComposerView : NSObject
@end

@interface LSComposerComponentStackView : UIView
@end

@interface MSGListBinder : NSObject <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, assign) BOOL didAddMNACellHeaderView;
@end

@interface LSContactListViewController : UIViewController {
  NSString *_featureIdentifier;
}
@end