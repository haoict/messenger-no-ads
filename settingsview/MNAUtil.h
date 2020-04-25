#define TWEAK_TITLE "Messenger No Ads"
#define PREF_BUNDLE_PATH "/Library/Application Support/MessengerNoAds.bundle"
#define PLIST_FILENAME "com.haoict.messengernoadspref.plist"
#define PREF_CHANGED_NOTIF "com.haoict.messengernoadspref/PrefChanged"
#define KTINT_COLOR "#B787FF" // [UIColor colorWithRed:0.72 green:0.53 blue:1.00 alpha:1.00]
#define KTINT_COLOR_DARKMODE "#B787FF" // don't know what looks good, better let it be the same with white mode

@interface NSTask : NSObject
@property (copy) NSArray *arguments;
@property (copy) NSString *currentDirectoryPath;
@property (copy) NSDictionary *environment;
@property (copy) NSString *launchPath;
@property (readonly) int processIdentifier;
@property (retain) id standardError;
@property (retain) id standardInput;
@property (retain) id standardOutput;
+ (id)currentTaskDictionary;
+ (id)launchedTaskWithDictionary:(id)arg1;
+ (id)launchedTaskWithLaunchPath:(id)arg1 arguments:(id)arg2;
- (id)init;
- (void)interrupt;
- (bool)isRunning;
- (void)launch;
- (bool)resume;
- (bool)suspend;
- (void)terminate;
@end

@interface MNAUtil : NSObject
+ (NSString *)localizedItem:(NSString *)key;
+ (UIColor *)colorFromHex:(NSString *)hexString;
+ (void)showAlertMessage:(NSString *)message title:(NSString *)title viewController:(id)vc;
+ (BOOL)isDarkMode;
+ (BOOL)isiPad;
@end