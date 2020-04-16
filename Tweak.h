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

@interface LSVideoPlayerView
- (void)startPlayMedia;
@end