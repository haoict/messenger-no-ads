#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Cephei/HBPreferences.h>
#import "NSTask.h"

@interface MNAAppearanceSettings : HBAppearanceSettings
@end

@interface MNARootListController : HBRootListController {
  UITableView * _table;
}

@property (nonatomic, retain) UIBarButtonItem *respringButton;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIImageView *headerImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *iconView;

-(void)killMessenger;
-(void)respring;

@end