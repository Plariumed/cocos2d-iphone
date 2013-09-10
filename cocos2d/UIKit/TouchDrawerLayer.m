//
//  TouchDrawerLayer.m
//  KidsMath
//
//  Created by Ivan Sinitsa on 9/9/13.
//  Copyright (c) 2013 Ivan Sinitsa. All rights reserved.
//

#import "TouchDrawerLayer.h"

@interface TouchDrawerLayer()

@property (nonatomic, retain) NSMutableDictionary *imageDictionary;

@end

@implementation TouchDrawerLayer

- (id)init
{
    self = [super init];
    if (self) {
        self.imageDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc
{
    self.imageDictionary = nil;
    [super dealloc];
}

- (void)addImageToForTouch:(UITouch *)touch
{
    NSString *touchId = @([touch hash]);
    UIView *view = [self.imageDictionary objectForKey:touchId];
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        view.center = [touch locationInView:touch.view];
        view.opaque = NO;
        view.layer.cornerRadius = 20;
        [touch.view addSubview:view];
        if (self.imageDictionary.count >= 5) {
            UIView *view = [self.imageDictionary.allValues objectAtIndex:0];
            [view removeFromSuperview];
            [self.imageDictionary removeObjectForKey:[self.imageDictionary.allKeys objectAtIndex:0]];
        }
        [self.imageDictionary setObject:view forKey:touchId];
    }
}

- (void)removeImageForTouch:(UITouch *)touch
{
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSString *touchId = @([touch hash]);
        UIView *view = [self.imageDictionary objectForKey:touchId];
        if (view) {
            [view removeFromSuperview];
            [self.imageDictionary removeObjectForKey:touchId];
        }
    });
}

- (void)moveImageForTouch:(UITouch *)touch
{
    NSString *touchId = @([touch hash]);
    UIView *view = [self.imageDictionary objectForKey:touchId];
    if (view) {
        view.center = [touch locationInView:touch.view];
    }
}

- (void)touchesBegan:(NSSet *)touches
{
    for (UITouch *touch in touches) {
        [self addImageToForTouch:touch];
    }
}

- (void)touchesMoved:(NSSet *)touches
{
    for (UITouch *touch in touches) {
        [self moveImageForTouch:touch];
    }
}

- (void)touchesEnded:(NSSet *)touches
{
    for (UITouch *touch in touches) {
        [self removeImageForTouch:touch];
    }

    
}

@end
