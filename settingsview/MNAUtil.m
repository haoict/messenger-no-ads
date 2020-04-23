#import "MNAUtil.h"

@implementation MNAUtil
+ (NSString *)localizedItem:(NSString *)key {
  NSBundle *tweakBundle = [NSBundle bundleWithPath:@PREF_BUNDLE_PATH];
  return [tweakBundle localizedStringForKey:key value:@"" table:@"Root"] ?: @"";
}

+ (UIColor *)colorFromHex:(NSString *)hexString {
  unsigned rgbValue = 0;
  if ([hexString hasPrefix:@"#"]) hexString = [hexString substringFromIndex:1];
  if (hexString) {
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  [scanner setScanLocation:0]; // bypass '#' character
  [scanner scanHexInt:&rgbValue];
  return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
  }
  else return [UIColor grayColor];
}

+ (void)showAlertMessage:(NSString *)message title:(NSString *)title viewController:(UIViewController *)vc {
  __block UIWindow* topWindow;
  if (!vc) {
    topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    topWindow.rootViewController = [UIViewController new];
    topWindow.windowLevel = UIWindowLevelAlert + 1;
  }
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:title ?: @"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
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