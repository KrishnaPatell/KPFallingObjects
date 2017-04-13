#import <UIKit/UIKit.h>

@interface KPFallingObjectView : UIView

@property (nonatomic, retain) NSMutableArray *flakesArray;
@property (nonatomic, retain) NSMutableArray *arrFlakeFileName;
@property (nonatomic, assign) NSInteger flakesCount;
@property (nonatomic, assign) float flakeWidth;
@property (nonatomic, assign) float flakeHeight;
@property (nonatomic, assign) float flakeMinimumSize;
@property (nonatomic, assign) float animationDurationMin;
@property (nonatomic, assign) float animationDurationMax;

- (void)beginFallAnimation;
- (void)endFallAnimation;

@end
