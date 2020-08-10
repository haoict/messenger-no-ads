#import <libhdev/HUtilities/HCommon.h>
#import "MNAUtil.h"
#import "MNACellModel.h"
#import "MNATableViewCell.h"

@interface MNASettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
  UITableView *_tableView;
  NSMutableArray *_tableData;
  UIView *_headerView;
  UIImageView *_headerImageView;
  UILabel *_titleLabel;
  UIImageView *_iconView;
  NSMutableDictionary *_originalSettings;
}
@end