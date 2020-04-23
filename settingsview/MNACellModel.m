#import "MNACellModel.h"

@implementation MNACellModel
- (MNACellModel *)initWithType:(CellType)type withLabel:(NSString *)label {
  self = [super init];
  self.type = type;
  self.label = label;
  return self;
}

- (MNACellModel *)initWithType:(CellType)type withLabel:(NSString *)label withSubtitle:(NSString *)subtitle {
  self = [super init];
  self.type = type;
  self.label = label;
  self.subtitle = subtitle; 
  return self;
}
@end