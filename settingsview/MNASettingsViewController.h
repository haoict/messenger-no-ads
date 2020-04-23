#import "MNAUtil.h"
#import "MNACellModel.h"
#import "MNATableViewCell.h"

@interface MNASettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
  UITableView *_tableView;
  NSMutableArray *_tableData;
}

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIImageView *headerImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *iconView;
@end