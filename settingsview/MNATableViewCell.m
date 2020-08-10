#import "MNATableViewCell.h"

#define LABEL_COLOR "#333333"
#define SUBTITLE_COLOR "#828282"
#define STATIC_BACKGROUND_COLOR "#EFEFF4"
#define CELL_BACKGROUND_COLOR "#FFFFFF"

#define LABEL_COLOR_DARKMODE "#F2F2F2"
#define SUBTITLE_COLOR_DARKMODE "#888888"
#define STATIC_BACKGROUND_COLOR_DARKMODE "#000000"
#define CELL_BACKGROUND_COLOR_DARKMODE "#1C1C1C"

#define STATIC_FONT_SIZE 13.0

@implementation MNATableViewCell
- (id)initWithData:(MNACellModel *)cellData reuseIdentifier:(NSString *)reuseIdentifier viewController:vc {
  self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
  _cellData = cellData;
  _vc = vc;
  _plistPath = [MNAUtil getPlistPath];
  if (self) {
    self.textLabel.text = cellData.label;
    self.textLabel.textColor = [HCommon colorFromHex:[HCommon isDarkMode] ? @LABEL_COLOR_DARKMODE : @LABEL_COLOR];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.detailTextLabel.text = cellData.subtitle;
    self.detailTextLabel.textColor = [HCommon colorFromHex:[HCommon isDarkMode] ? @SUBTITLE_COLOR_DARKMODE : @SUBTITLE_COLOR];
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
        self.contentView.backgroundColor = [HCommon colorFromHex:[HCommon isDarkMode] ? @STATIC_BACKGROUND_COLOR_DARKMODE : @STATIC_BACKGROUND_COLOR];
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
  if (highlighted) {
    if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
      self.contentView.superview.backgroundColor = [[HCommon colorFromHex:@KTINT_COLOR] colorWithAlphaComponent:0.3];
    }
  } else {
    self.contentView.superview.backgroundColor = [HCommon colorFromHex:[HCommon isDarkMode] ? @CELL_BACKGROUND_COLOR_DARKMODE : @CELL_BACKGROUND_COLOR];
  }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  if (selected) {
    if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
      self.contentView.superview.backgroundColor = [[HCommon colorFromHex:@KTINT_COLOR] colorWithAlphaComponent:0.3];
    }
  } else {
    self.contentView.superview.backgroundColor = [HCommon colorFromHex:[HCommon isDarkMode] ? @CELL_BACKGROUND_COLOR_DARKMODE : @CELL_BACKGROUND_COLOR];
  }
}

- (void)setPreferenceValue:(id)value {
  NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:_plistPath] ?: [@{} mutableCopy];
  [settings setObject:value forKey:_cellData.prefKey];
  BOOL success = [settings writeToFile:_plistPath atomically:YES];

  if (!success) {
    [HCommon showAlertMessage:@"Can't write file" withTitle:@"Error" viewController:nil];
  } else {
    notify_post(PREF_CHANGED_NOTIF);

    // if (_cellData.isRestartRequired) {
    //   [MNAUtil showRequireRestartAlert:_vc];
    // }
  }
}

- (id)readPreferenceValueForKey:(NSString *)prefKey {
  NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:_plistPath] ?: [@{} mutableCopy];
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
@end