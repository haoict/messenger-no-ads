// Disable Typing Indicator Interfaces
@interface LSTextView : UITextView
@property(nonatomic) _Bool collapsed;
- (void)updateSizeAnimated:(_Bool)arg1;
@end

@interface LSComposerViewController : UIViewController
+ (id)sharedInstance;
- (void)setTextChangedSinceTextViewCollapsed:(BOOL)arg1;
- (void)updateComposerBarState;
@end

// // Tab bar interface
// @interface UITabBarController : UIViewController
// @property(nonatomic, assign, readonly) UITabBar * tabBar;
// @end

// Story Interfaces
@interface MBUIStoryViewerStoryIdentifierModel : NSObject
@property(readonly, nonatomic) _Bool isPostingFailed;
@property(readonly, nonatomic) _Bool isRead;
@property(readonly, nonatomic) _Bool isExpired;
@property(readonly, nonatomic) _Bool isBeingDeleted;
@property(readonly, nonatomic) _Bool isBeingPosted;
@property(readonly, copy, nonatomic) NSString *mediaPreviewUrl;
@property(readonly, nonatomic) int mediaType;
@property(readonly, copy, nonatomic) NSString *mediaId;
@property(readonly, nonatomic) int bucketType;
@property(readonly, nonatomic) int storyType;
@property(readonly, copy, nonatomic) NSString *ownerId;
@property(readonly, copy, nonatomic) NSString *authorFirstName;
@property(readonly, nonatomic) long long storyId;
@end

@interface LSThreadMediaViewerBucketViewController : UIViewController
@property(readonly, nonatomic) id threadMediaViewerBucketLoggingInfo; 
@property(readonly, nonatomic) BOOL isPlaying;
@end