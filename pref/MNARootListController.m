#include "MNARootListController.h"

#define TWEAK_TITLE "Messenger No Ads"
#define PLIST_PATH "/var/mobile/Library/Preferences/com.haoict.messengernoadspref.plist"
#define PREF_BUNDLE_PATH "/Library/PreferenceBundles/MNAPref.bundle"
#define PREF_CHANGED_NOTIF "com.haoict.messengernoadspref/PrefChanged"
#define kTintColor [UIColor colorWithRed:0.72 green:0.53 blue:1.00 alpha:1.00];

/**
 * Header, logo
 */
@implementation MNAHeader
- (id)initWithSpecifier:(PSSpecifier *)specifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  if (self) {
    #define kWidth [[UIApplication sharedApplication] keyWindow].frame.size.width
    NSArray *subtitles = [NSArray arrayWithObjects:@"By @haoict", @"Free and Open Source!", nil];

    CGRect labelFrame = CGRectMake(0, -15, kWidth, 80);
    CGRect underLabelFrame = CGRectMake(0, 35, kWidth, 60);

    label = [[UILabel alloc] initWithFrame:labelFrame];
    [label setNumberOfLines:1];
    label.font = [UIFont systemFontOfSize:35];
    [label setText:@TWEAK_TITLE];
    label.textColor = kTintColor;
    label.textAlignment = NSTextAlignmentCenter;

    underLabel = [[UILabel alloc] initWithFrame:underLabelFrame];
    [underLabel setNumberOfLines:1];
    underLabel.font = [UIFont systemFontOfSize:15];
    uint32_t rnd = arc4random_uniform([subtitles count]);
    [underLabel setText:[subtitles objectAtIndex:rnd]];
    underLabel.textColor = [UIColor grayColor];
    underLabel.textAlignment = NSTextAlignmentCenter;

    [self addSubview:label];
    [self addSubview:underLabel];
  }
  return self;
}
- (CGFloat)preferredHeightForWidth:(CGFloat)arg1 {
  CGFloat prefHeight = 75.0;
  return prefHeight;
}
@end

/**
 * Root: No change if not needed
 */
@implementation MNARootListController
MNARootListController *sharedInstance;
+ (id)sharedInstance {
  return sharedInstance;
}
+ (NSString *)localizedItem:(NSString *)key {
  NSBundle *tweakBundle = [NSBundle bundleWithPath:@PREF_BUNDLE_PATH];
  return [tweakBundle localizedStringForKey:key value:@"" table:@"Root"] ?: @"";
}
- (id)init {
  self = [super init];
  if (self) {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[MNARootListController localizedItem:@"APPLY"] style:UIBarButtonItemStylePlain target:self action:@selector(apply)];;
  }
  sharedInstance = self;
  return self;
}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
  self.view.tintColor = kTintColor;
  keyWindow.tintColor = kTintColor;
  [UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]].onTintColor = kTintColor;
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
  keyWindow.tintColor = nil;
}
- (NSArray *)specifiers {
  if (!_specifiers) {
    _specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
  }
  /** Localize sublabel **/
  for (PSSpecifier *spec in _specifiers) {
    NSString *sublabelValue = [spec.properties objectForKey:@"sublabel"];
    if (sublabelValue) {
      [spec setProperty:[MNARootListController localizedItem:sublabelValue] forKey:@"sublabel"];
    }
  }

  /** Disable Hide Search Bar for ios 13 - begin **/
  if (@available(iOS 13, *)) {
    for (PSSpecifier *spec in _specifiers) {
      if ([[spec.properties objectForKey:@"key"] isEqual:@"hidesearchbar"]) {
        [spec setProperty:@FALSE forKey:@"enabled"];
      }
    }
  }
  /** Disable Hide Search Bar for ios 13 - end   **/

  return _specifiers;
}
- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
  NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH] ?: [@{} mutableCopy];
  [settings setObject:value forKey:[[specifier properties] objectForKey:@"key"]];
  [settings writeToFile:@PLIST_PATH atomically:YES];
  notify_post(PREF_CHANGED_NOTIF);
}
- (id)readPreferenceValue:(PSSpecifier *)specifier {
  NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:@PLIST_PATH];
  return settings[[[specifier properties] objectForKey:@"key"]] ?: [[specifier properties] objectForKey:@"default"];
}
- (void)resetSettings:(PSSpecifier *)specifier  {
  [@{} writeToFile:@PLIST_PATH atomically:YES];
  [self reloadSpecifiers];
  notify_post(PREF_CHANGED_NOTIF);
}
- (void)openURL:(PSSpecifier *)specifier  {
  UIApplication *app = [UIApplication sharedApplication];
  NSString *url = [specifier.properties objectForKey:@"url"];
  [app openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
}

/**
 * Apply top right button
 */
-(void)apply {
  UIAlertController *killConfirm = [UIAlertController alertControllerWithTitle:@TWEAK_TITLE message:[MNARootListController localizedItem:@"DO_YOU_REALLY_WANT_TO_KILL_MESSENGER"] preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:[MNARootListController localizedItem:@"CONFIRM"] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
    NSTask *killall = [[NSTask alloc] init];
    [killall setLaunchPath:@"/usr/bin/killall"];
    [killall setArguments:@[@"-9", @"Messenger", @"LightSpeedApp"]];
    [killall launch];
  }];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[MNARootListController localizedItem:@"CANCEL"] style:UIAlertActionStyleCancel handler:nil];
  [killConfirm addAction:confirmAction];
  [killConfirm addAction:cancelAction];
  [self presentViewController:killConfirm animated:YES completion:nil];
}

- (void)respring {
  NSTask *killall = [[NSTask alloc] init];
  [killall setLaunchPath:@"/usr/bin/killall"];
  [killall setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
  [killall launch];
}

@end
