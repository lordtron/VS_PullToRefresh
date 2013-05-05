//
//  VS_PullToRefresh.m
//
//  Created by LordTron on 5/5/13.
//  Copyright (c) 2013 LordTron. All rights reserved.
//

#import "VS_PullToRefresh.h"
#import <objc/message.h>
#import <QuartzCore/QuartzCore.h>

@implementation VS_PullToRefresh
@synthesize delegate;
@synthesize selector;

- (id) initWithDelegate:(id<VS_PullToRefreshDelegate>)sender {
	self = [super init];
	if (self) {
		self->delegate = sender;

		title = [[UILabel alloc] init];
		[title setBackgroundColor:[UIColor clearColor]];
		[title setTextAlignment:NSTextAlignmentCenter];
		[title setFont:[UIFont boldSystemFontOfSize:14.0f]];
		[title setTextColor:[UIColor whiteColor]];
		[title setText:@"Pull to refresh"];
		[self addSubview:title];

		refresh_icon = [[UIImageView alloc] init];
		[refresh_icon setImage:[UIImage imageNamed:@"vs_refreshicon"]];
		[self addSubview:refresh_icon];
	}
	return self;
}
- (void) showInView:(UICollectionView *) sender {
	static float height = 50.0f;
	float offsetTop = [sender contentInset].top;
	float width = CGRectGetWidth([sender frame]);

	[self setFrame:CGRectMake(0, -height-offsetTop, width, height)];
	[title setFrame:[self bounds]];
	[refresh_icon setFrame:CGRectMake(60.0f, (height/2)-16, 32, 32)];
	[sender addSubview:self];
}
- (void) beginRefreshing {
	dispatch_async(dispatch_get_main_queue(), ^{
		if([[[refresh_icon layer] animationKeys] count] > 0)
			return;

		static int duration = 30;
		CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
		[rotationAnimation setToValue:[NSNumber numberWithFloat: (M_PI * 2.0 * duration)]];
		[rotationAnimation setDuration:duration];
		[rotationAnimation setCumulative:true];
		[rotationAnimation setRepeatCount:0];
		[[refresh_icon layer] addAnimation:rotationAnimation forKey:@"rotationAnimation"];
	});
}
- (void) endRefreshing {
	dispatch_async(dispatch_get_main_queue(), ^{
		[[refresh_icon layer] removeAllAnimations];
	});
}

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	if([[[refresh_icon layer] animationKeys] count] > 0)
		return;

	float y = [scrollView contentOffset].y;
	if(y <= -(CGRectGetHeight([self bounds])+20)){
		SEL strSelector = NSSelectorFromString(selector);
		if([(UIViewController *)[self delegate] canPerformAction:strSelector withSender:nil]){
			objc_msgSend([self delegate], strSelector);
		}
	}
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	float y = [scrollView contentOffset].y;

	if(y < -(CGRectGetHeight([self bounds])+20))
		[title setText:@"Release to Refresh"];
	else
		[title setText:@"Pull to Refresh"];
}


@end