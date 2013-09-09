//
//  TouchDrawerLayer.h
//  KidsMath
//
//  Created by Ivan Sinitsa on 9/9/13.
//  Copyright (c) 2013 Ivan Sinitsa. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface TouchDrawerLayer : CALayer

- (void)touchesBegan:(NSSet *)touches;
- (void)touchesMoved:(NSSet *)touches;
- (void)touchesEnded:(NSSet *)touches;

@end
