#import "messengernoadscc.h"

#define TWEAK_TITLE "Messenger No Ads"
#define PLIST_PATH "/var/mobile/Library/Preferences/com.haoict.messengernoadspref.plist"

@implementation messengernoadscc

- (UIImage *)iconGlyph {
  return [UIImage imageNamed:@"seen-enable" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

- (UIImage *)selectedIconGlyph {
  return [UIImage imageNamed:@"seen-disable" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

- (UIColor *)selectedColor {
  return [UIColor colorWithRed:0.28 green:0.21 blue:0.58 alpha:1.00];
}

- (BOOL)isSelected {
  NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH];
  _selected = [[settings objectForKey:@"disablereadreceipt"]?:@(YES) boolValue];
  return _selected;
}

- (void)setSelected:(BOOL)selected {
  _selected = selected;
  [super refreshState];

  NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH] ?: [@{} mutableCopy];
  if(_selected) {
    [settings setObject:@(NO) forKey:@"disablereadreceipt"];
  }
  else {
    [settings setObject:@(YES) forKey:@"disablereadreceipt"];
  }
  [settings writeToFile:@PLIST_PATH atomically:YES];
  notify_post("com.haoict.messengernoadspref/ReloadPrefs");

  // show get top window
  // __block UIWindow* topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  // topWindow.rootViewController = [UIViewController new];
  // topWindow.windowLevel = UIWindowLevelAlert + 1;
  // UIAlertController* alert = [UIAlertController alertControllerWithTitle:@TWEAK_TITLE message:[NSString stringWithFormat:@"%@ %@", selected ? @"Disabled" : @"Enabled", @"Read Receipt. Please kill Messenger from Task Switcher to make effect"] preferredStyle:UIAlertControllerStyleAlert];
  // [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK",@"confirm") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
  //     topWindow.hidden = YES;
  //     topWindow = nil;
  // }]];
  // [topWindow makeKeyAndVisible];
  // [topWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
