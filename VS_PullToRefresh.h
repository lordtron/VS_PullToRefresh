//
//  VS_PullToRefresh.h
//
//  Created by LordTron on 5/5/13.
//  Copyright (c) 2013 LordTron. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VS_PullToRefreshDelegate <NSObject>
@end

@interface VS_PullToRefresh : UIView {
	UIImageView * refresh_icon;
	UILabel * title;
}

@property (nonatomic, assign) id<VS_PullToRefreshDelegate> delegate;
@property (nonatomic) NSString * selector;


- (id) initWithDelegate:(id<VS_PullToRefreshDelegate>) sender;
- (void) showInView:(UIView *) sender;

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void) scrollViewDidScroll:(UIScrollView *)scrollView;

- (void) beginRefreshing;
- (void) endRefreshing;

@end
