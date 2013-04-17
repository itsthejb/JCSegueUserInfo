//
//  UIViewController+SegueUserInfo.h
//  JCSegueUserInfo
//
//  Created by Jonathan Crooke on 17/04/2013.
//  Copyright (c) 2013 Jonathan Crooke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SegueUserInfo)

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender userInfo:(NSDictionary*) userInfo NS_AVAILABLE_IOS(5_0);

@end
