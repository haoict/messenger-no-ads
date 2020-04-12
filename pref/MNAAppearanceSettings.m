#import "MNARootListController.h"

@implementation MNAAppearanceSettings

-(UIColor *)tintColor {
    return [UIColor colorWithRed:0.75 green:0.80 blue:0.98 alpha:1.0];
}

-(UIColor *)statusBarTintColor {
    return [UIColor whiteColor];
}

-(UIColor *)navigationBarTitleColor {
    return [UIColor whiteColor];
}

-(UIColor *)navigationBarTintColor {
    return [UIColor whiteColor];
}

-(UIColor *)tableViewCellSeparatorColor {
    return [UIColor colorWithWhite:0 alpha:0];
}

-(UIColor *)navigationBarBackgroundColor {
    return [UIColor colorWithRed:0.75 green:0.80 blue:0.98 alpha:1.0];
}

-(BOOL)translucentNavigationBar {
    return NO;
}

- (NSUInteger)largeTitleStyle {
    return 2;
}

@end