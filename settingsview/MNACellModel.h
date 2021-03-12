#import <Foundation/Foundation.h>

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
@property (nonatomic) NSString * url; // only for Link type
@property (nonatomic) SEL buttonAction; // only for Button type
@property (nonatomic) BOOL isRestartRequired; // only for Button type
@property (nonatomic) BOOL disabled;

- (MNACellModel *)initWithType:(CellType)type withLabel:(NSString *)label;
- (MNACellModel *)initWithType:(CellType)type withLabel:(NSString *)label withSubtitle:(NSString *)subtitle;
@end