#include "MNARootListController.h"

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
    [label setText:@"Messenger No Ads"];
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
- (id)init {
  self = [super init];
  if (self) {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply)];;
  }
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
  return _specifiers;
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
  UIAlertController *killConfirm = [UIAlertController alertControllerWithTitle:@"Messenger No Ads" message:@"Do you really want to kill Messenger?" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
    NSTask *killall = [[NSTask alloc] init];
    [killall setLaunchPath:@"/usr/bin/killall"];
    [killall setArguments:@[@"-9", @"Messenger", @"LightSpeedApp"]];
    [killall launch];
  }];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
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
