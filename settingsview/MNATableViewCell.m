#import "MNATableViewCell.h"

#define LABEL_COLOR "#333333"
#define SUBTITLE_COLOR "#828282"
#define STATIC_BACKGROUND_COLOR "#EFEFF4"
#define STATIC_FONT_SIZE 13.0

@implementation MNATableViewCell
- (id)initWithData:(MNACellModel *)cellData reuseIdentifier:(NSString *)reuseIdentifier viewController:vc {
  self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
  _cellData = cellData;
  _vc = vc;
  _plistPath = [NSString stringWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @PLIST_FILENAME];

  if (self) {
    self.textLabel.text = cellData.label;
    self.textLabel.textColor = [MNAUtil colorFromHex:@LABEL_COLOR];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.detailTextLabel.text = cellData.subtitle;
    self.detailTextLabel.textColor = [MNAUtil colorFromHex:@SUBTITLE_COLOR];
    if (cellData.disabled) {
      self.userInteractionEnabled = NO;
      self.textLabel.enabled = NO;
    }

    switch (cellData.type) {
      case Switch: {
        [self loadSwitcher];
        break;
      }

      case Button:
      case Link: {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        break;
      }

      case StaticText: {
        self.textLabel.font=[UIFont systemFontOfSize:STATIC_FONT_SIZE];
        self.contentView.backgroundColor = [MNAUtil colorFromHex:@STATIC_BACKGROUND_COLOR];
        break;
      }

      case Default:
      default:
        break;
    }
  }
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
  switch (_cellData.type) {
    case Switch: {
      [self loadSwitcher];
      break;
    }
    default:
      break;
  }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  [super setHighlighted:highlighted animated:animated];
  if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
    if (highlighted) {
      self.contentView.superview.backgroundColor = [kTintColor colorWithAlphaComponent:0.3];
    } else {
      self.contentView.superview.backgroundColor = [UIColor whiteColor];
    }
  }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
    if (selected) {
      self.contentView.superview.backgroundColor = [kTintColor colorWithAlphaComponent:0.3];
    } else {
      self.contentView.superview.backgroundColor = [UIColor whiteColor];
    }
  }
}

- (void)setPreferenceValue:(id)value {
  NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:_plistPath] ?: [@{} mutableCopy];
  [settings setObject:value forKey:_cellData.prefKey];
  NSURL *filePath = [NSURL fileURLWithPath:_plistPath];
  NSError *error;
  BOOL success = [settings writeToURL:filePath error:&error];

  if (!success) {
    [MNAUtil showAlertMessage:[NSString stringWithFormat:@"Can't write file: %@", [error localizedDescription]] title:@"Error" viewController:_vc];
  } else {
    notify_post(PREF_CHANGED_NOTIF);
  }
}

- (id)readPreferenceValueForKey:(NSString *)prefKey {
  NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:_plistPath];
  return settings[prefKey];
}

- (void)switchChanged:(id)sender {
  UISwitch *switchControl = sender;
  [self setPreferenceValue:[NSNumber numberWithBool:switchControl.on]];
}

- (void)loadSwitcher {
  UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
  self.accessoryView = switchView;
  id savedValue = [self readPreferenceValueForKey:_cellData.prefKey];
  BOOL value;
  if (savedValue == nil) {
    value = [[_cellData.defaultValue uppercaseString] isEqual:@"TRUE"];
  } else {
    value = [savedValue boolValue];
  }
  [switchView setOn:value animated:NO];
  [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];

  if (_cellData.disabled) {
    switchView.enabled = NO;
  }
}

// - (void)resetSettings:(id)sender {
//   [@{} writeToFile:@PLIST_PATH atomically:YES];
//   [self reloadSpecifiers];
//   notify_post(PREF_CHANGED_NOTIF);
// }
@end