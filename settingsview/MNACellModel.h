typedef NS_ENUM(NSUInteger, CellType) {
  Default,
  StaticText,
  Switch,
  Button,
  Link
};

@interface MNACellModel : NSObject
@property (nonatomic) CellType type;
@property (nonatomic) NSString * label;
@property (nonatomic) NSString * subtitle;
@property (nonatomic) NSString * prefKey;
@property (nonatomic) NSString * defaultValue;
@property (nonatomic) NSString * url;
@property (nonatomic) SEL buttonAction;
@property (nonatomic) BOOL disabled;

- (MNACellModel *)initWithType:(CellType)type withLabel:(NSString *)label;
- (MNACellModel *)initWithType:(CellType)type withLabel:(NSString *)label withSubtitle:(NSString *)subtitle;
@end