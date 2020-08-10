#import <libhdev/HUtilities/HCommon.h>

#define TWEAK_TITLE "Messenger No Ads"
#define PREF_BUNDLE_PATH "/Library/Application Support/MessengerNoAds.bundle"
#define PLIST_FILENAME "com.haoict.messengernoadspref.plist"
#define PREF_CHANGED_NOTIF "com.haoict.messengernoadspref/PrefChanged"
#define KTINT_COLOR "#B787FF" // [UIColor colorWithRed:0.72 green:0.53 blue:1.00 alpha:1.00]
#define KTINT_COLOR_DARKMODE "#B787FF" // don't know what looks good, better let it be the same with white mode

@interface MNAUtil : NSObject
+ (NSString *)localizedItem:(NSString *)key;
+ (void)showRequireRestartAlert:(UIViewController *)vc;
+ (NSString *)getPlistPath;
+ (NSMutableDictionary *)getCurrentSettingsFromPlist;
+ (NSDictionary *)compareNSDictionary:(NSDictionary *)d1 withNSDictionary:(NSDictionary *)d2;
@end