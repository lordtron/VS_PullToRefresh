VS_PullToRefresh
================

A solution for Pull to Refresh for UICollectionView/UICollectionViewController


Requirements ARC + Quartz Framework


To use in your projects, include all files.
Init a variable for VS_PullToRefresh:

First line init's the class. The 2nd line tells the class which UICollectionView/UICollectionViewController to display on. Then the 3rd line tells the class what function to call when pulled down.

refreshControl = [[VS_PullToRefresh alloc] initWithDelegate:(id<VS_PullToRefreshDelegate>)self];
[refreshControl showInView:[self collectionView]];
[refreshControl setSelector:@"pull_results"];


And include the following functions:

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	[refreshControl scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	[refreshControl scrollViewDidScroll:scrollView];
} 

The above functions will allow VS_PullToRefresh detect the pull down and call the selector when released