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
@end