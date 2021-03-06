//
//  EGOViewCommon.h
//  TableViewRefresh
//
//  Created by  Abby Lin on 12-5-2.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef TableViewRefresh_EGOViewCommon_h
#define TableViewRefresh_EGOViewCommon_h
#import "UIColor+expanded.h"

#define REFRESH_VIEW_BG	 [UIColor colorWithHexString:@"0xeeeeee"]
#define TEXT_COLOR	 [UIColor colorWithHexString:@"0x999999"]

#define FLIP_ANIMATION_DURATION 0.18f

#define  REFRESH_REGION_HEIGHT 65.0f

typedef enum{
	EGOOPullRefreshPulling = 0,
	EGOOPullRefreshNormal,
	EGOOPullRefreshLoading,	
} EGOPullRefreshState;

typedef enum{
	EGORefreshHeader = 0,
	EGORefreshFooter	
} EGORefreshPos;

@protocol EGORefreshTableDelegate
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos;
- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view;
@optional
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view;
@end

#endif
