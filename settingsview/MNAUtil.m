#import "MNAUtil.h"

@implementation MNAUtil
+ (NSString *)localizedItem:(NSString *)key {
  return [HCommon localizedItem:key bundlePath:@PREF_BUNDLE_PATH];
}

+ (void)showRequireRestartAlert:(UIViewController *)vc {
  __block UIWindow* topWindow;
  if (!vc) {
    topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    topWindow.rootViewController = [UIViewController new];
    topWindow.windowLevel = UIWindowLevelAlert + 1;
  }
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:[MNAUtil localizedItem:@"APP_RESTART_REQUIRED"] message:[MNAUtil localizedItem:@"DO_YOU_REALLY_WANT_TO_KILL_MESSENGER"] preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:[MNAUtil localizedItem:@"CONFIRM"] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    if (!vc) {
      topWindow.hidden = YES;
      topWindow = nil;
    }
    exit(0);
  }]];

  [alert addAction:[UIAlertAction actionWithTitle:[MNAUtil localizedItem:@"CANCEL"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    if (!vc) {
      topWindow.hidden = YES;
      topWindow = nil;
    }
  }]];

  if (!vc) {
    [topWindow makeKeyAndVisible];
    [topWindow.rootViewController presentViewController:alert animated:YES completion:nil];
  } else {
    [vc presentViewController:alert animated:YES completion:nil];
  }
}

+ (NSString *)getPlistPath {
  return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@PLIST_FILENAME];
}

+ (NSMutableDictionary *)getCurrentSettingsFromPlist {
  return [[NSMutableDictionary alloc] initWithContentsOfFile:[MNAUtil getPlistPath]] ?: [@{} mutableCopy];
}

+ (NSDictionary *)compareNSDictionary:(NSDictionary *)d1 withNSDictionary:(NSDictionary *)d2 {
  NSMutableDictionary *result = NSMutableDictionary.dictionary;

  // Find objects in d1 that don't exist or are different in d2
  [d1 enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    id otherObj = d2[key];

    if (![obj isEqual:otherObj]) {
      result[key] = obj;
    }
  }];

  // Find objects in d2 that don't exist in d1
  [d2 enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    id d1Obj = d1[key];

    if (!d1Obj) {
      result[key] = obj;
    }
  }];

  return result;
}
@end