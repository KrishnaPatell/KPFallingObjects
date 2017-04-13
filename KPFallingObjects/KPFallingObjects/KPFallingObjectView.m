#import "KPFallingObjectView.h"
#import <QuartzCore/QuartzCore.h>
#import <float.h>
#import <math.h>
#import <stdlib.h>
#import <stdint.h>

#define kDefaultFlakesCount 80
#define kDefaultFlakeWidth 20.0
#define kDefaultFlakeHeight 23.0
#define kDefaultMinimumSize 0.4
#define kDefaultAnimationDurationMin 6.0
#define kDefaultAnimationDurationMax 10.0
#define kDefaultArrFlakeFileName   [[NSMutableArray alloc] initWithObjects : @"2.png", @"4.png", @"8.png", @"16.png", nil];
@implementation KPFallingObjectView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.clipsToBounds          = YES;
        self.backgroundColor        = [UIColor clearColor];
        self.userInteractionEnabled = NO;

        // Set default values
        self.flakesCount          = kDefaultFlakesCount;
        self.flakeWidth           = kDefaultFlakeWidth;
        self.flakeHeight          = kDefaultFlakeHeight;
        self.flakeMinimumSize     = kDefaultMinimumSize;
        self.animationDurationMin = kDefaultAnimationDurationMin;
        self.animationDurationMax = kDefaultAnimationDurationMax;
        self.arrFlakeFileName = kDefaultArrFlakeFileName;
    }
    return self;
}


- (void)beginFallAnimation {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Clean up if we go to the background as CABasicAnimations tend to do odd things then
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFallAnimationFromNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];

    // Prepare Rotation Animation
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.repeatCount       = HUGE_VALF;
    rotationAnimation.autoreverses      = NO;
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];	// 360 degrees in radians

    // Prepare Vertical Motion Animation
    CABasicAnimation *fallAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    fallAnimation.repeatCount       = HUGE_VALF;
    fallAnimation.autoreverses      = NO;

    for (UIImageView *flake in self.flakesArray) {
        CGPoint flakeStartPoint     = flake.center;
        float flakeStartY           = flakeStartPoint.y;
        float flakeEndY             = self.frame.size.height;
        flakeStartPoint.y           = flakeEndY;
        flake.center                = flakeStartPoint;

        // Randomize the time each flake takes to animate to give texture
        float timeInterval = (self.animationDurationMax - self.animationDurationMin) * arc4random() / UINT32_MAX;
        fallAnimation.duration = timeInterval + self.animationDurationMin;
        fallAnimation.fromValue = [NSNumber numberWithFloat:-flakeStartY];
        [flake.layer addAnimation:fallAnimation forKey:@"transform.translation.y"];

        rotationAnimation.duration = timeInterval * 1; // Makes sure that we don't get super-fast spinning flakes
        [flake.layer addAnimation:rotationAnimation forKey:@"transform.rotation.y"];
    }
}


- (void)endFallAnimationFromNotification:(NSNotification *)notification {
    [self endFallAnimation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginFallAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];
}


- (void)endFallAnimation {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for (UIImageView *flake in self.flakesArray) {
        [flake removeFromSuperview];
    }
    _flakesArray = nil;
}


-(NSMutableArray *)flakesArray {
    if (!_flakesArray) {
        srandomdev();
        self.flakesArray = [[NSMutableArray alloc] initWithCapacity:self.flakesCount];

        for (int i = 0; i < self.flakesCount; i++) {
            // Randomize Flake size
            float flakeScale = 1.0 * arc4random() / UINT32_MAX;

            UIImage *flakeImg =[UIImage imageNamed:[_arrFlakeFileName objectAtIndex:[self generateRandomNumberWithlowerBound:0 upperBound:(int)_arrFlakeFileName.count ]]];
            
            // Make sure that we don't break the current size rules
            flakeScale          = flakeScale < self.flakeMinimumSize ? self.flakeMinimumSize : flakeScale;
            float flakeWidth    = self.flakeWidth * flakeScale;
            float flakeHeight   = self.flakeHeight * flakeScale;

            // Allow flakes to be partially offscreen
            float flakeXPosition = self.frame.size.width * arc4random() / UINT32_MAX;
            flakeXPosition -= flakeWidth;

            // enlarge content height by 1/2 view height, screen is always well populated
            float flakeYPosition = self.frame.size.height * 1.5 * arc4random() / UINT32_MAX;
            // flakes start y position is above upper view bound, add view height
            flakeYPosition += self.frame.size.height;

            CGRect frame = CGRectMake(flakeXPosition, flakeYPosition, flakeWidth, flakeHeight);

            UIImageView *imageView = [[UIImageView alloc] initWithImage:flakeImg];
            imageView.frame = frame;
            imageView.userInteractionEnabled = NO;

            [self.flakesArray addObject:imageView];
            [self addSubview:imageView];
        }
    }
    return _flakesArray;
}

-(int) generateRandomNumberWithlowerBound:(int)lowerBound
                               upperBound:(int)upperBound
{
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    return rndValue;
}
@end
