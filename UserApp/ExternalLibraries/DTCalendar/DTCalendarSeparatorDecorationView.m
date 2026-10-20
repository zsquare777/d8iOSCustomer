

#import "DTCalendarSeparatorDecorationView.h"
#import "DTCalendarConstants.h"

@implementation DTCalendarSeparatorDecorationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = DTCalendarStandardSeparatorColor;
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.frame = layoutAttributes.frame;
}

@end
