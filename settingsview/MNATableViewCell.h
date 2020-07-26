#import <libhdev/HUtilities/HCommon.h>
#import <notify.h>
#import "MNAUtil.h"
#import "MNACellModel.h"

@interface MNATableViewCell : UITableViewCell {
  MNACellModel *_cellData;
  UIViewController *_vc;
  NSString *_plistPath;
}
- (id)initWithData:(MNACellModel *)cellData reuseIdentifier:(NSString *)reuseIdentifier viewController:vc;
@end