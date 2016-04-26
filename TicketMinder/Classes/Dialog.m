/*
 * Copyright 2009 Facebook
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0

 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/
#import "Dialog.h"
@implementation Dialog


@synthesize delegate;

///////////////////////////////////////////////////////////////////////////////////////////////////
// global

static NSString* kDefaultTitle = @"Terms And Conditions";
static NSString* kStringBoundary = @"3i2ndDfv2rTHiSisAbouNdArYfORhtTPEefj3q2f";

static CGFloat kFacebookBlue[4] = {0, 0, 0, 1.0};
static CGFloat kBorderGray[4] = {0.3, 0.3, 0.3, 0.8};


static CGFloat kTransitionDuration = 1;

static CGFloat kTitleMarginX = 8;
static CGFloat kTitleMarginY = 4;

static CGFloat kBorderWidth = 10;

///////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
  CGContextBeginPath(context);
  CGContextSaveGState(context);

  if (radius == 0) {
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddRect(context, rect);
  } else {
    rect = CGRectOffset(CGRectInset(rect, 0.5, 0.5), 0.5, 0.5);
    CGContextTranslateCTM(context, CGRectGetMinX(rect)-0.5, CGRectGetMinY(rect)-0.5);
    CGContextScaleCTM(context, radius, radius);
    float fw = CGRectGetWidth(rect) / radius;
    float fh = CGRectGetHeight(rect) / radius;
    
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
  }

//  CGContextClosePath(context);
//  CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect fill:(const CGFloat*)fillColors radius:(CGFloat)radius {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();

  if (fillColors) {
 CGContextSaveGState(context);
 CGContextSetFillColor(context, fillColors);
    if (radius) {
      [self addRoundedRectToPath:context rect:rect radius:radius];
      CGContextFillPath(context);
    } else {
      CGContextFillRect(context, rect);
    }
    CGContextRestoreGState(context);
  }
  CGColorSpaceRelease(space);
}

- (void)strokeLines:(CGRect)rect stroke:(const CGFloat*)strokeColor {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();

  CGContextSaveGState(context);
  CGContextSetStrokeColorSpace(context, space);
  CGContextSetStrokeColor(context, strokeColor);
  CGContextSetLineWidth(context, 1.0);
    
  {
    CGPoint points[] = {rect.origin.x+0.5, rect.origin.y-0.5,
      rect.origin.x+rect.size.width, rect.origin.y-0.5};
    CGContextStrokeLineSegments(context, points, 2);
  }
  {
    CGPoint points[] = {rect.origin.x+0.5, rect.origin.y+rect.size.height-0.5,
      rect.origin.x+rect.size.width-0.5, rect.origin.y+rect.size.height-0.5};
    CGContextStrokeLineSegments(context, points, 2);
  }
  {
    CGPoint points[] = {rect.origin.x+rect.size.width-0.5, rect.origin.y,
      rect.origin.x+rect.size.width-0.5, rect.origin.y+rect.size.height};
    CGContextStrokeLineSegments(context, points, 2);
  }
  {
    CGPoint points[] = {rect.origin.x+0.5, rect.origin.y,
      rect.origin.x+0.5, rect.origin.y+rect.size.height};
    CGContextStrokeLineSegments(context, points, 2);
  }
  
  CGContextRestoreGState(context);

  CGColorSpaceRelease(space);
}

- (BOOL)shouldRotateToOrientation:(UIDeviceOrientation)orientation {
  if (orientation) {
    return NO;
  } else {
    return orientation == UIDeviceOrientationLandscapeLeft
      || orientation == UIDeviceOrientationLandscapeRight
      || orientation == UIDeviceOrientationPortrait
      || orientation == UIDeviceOrientationPortraitUpsideDown;
  }
}

- (CGAffineTransform)transformForOrientation {
  UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
  if (orientation == UIInterfaceOrientationLandscapeLeft) {
    return CGAffineTransformMakeRotation(M_PI*1.5);
  } else if (orientation == UIInterfaceOrientationLandscapeRight) {
    return CGAffineTransformMakeRotation(M_PI/2);
  } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
    return CGAffineTransformMakeRotation(-M_PI);
  } else {
    return CGAffineTransformIdentity;
  }
}


- (void)bounce1AnimationStopped {
  
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:kTransitionDuration];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
//    self.transform = CGAffineTransformScale([self transformForOrientation], 0.1, 0.1);
//    [UIView commitAnimations];
    
}

- (void)bounce2AnimationStopped {
//  
//[UIView beginAnimations:nil context:nil];
//  [UIView setAnimationDuration:kTransitionDuration];
//  self.transform = [self transformForOrientation];
//  [UIView commitAnimations];
    
    
}



- (void)dismiss:(BOOL)animated {
  
    [self dialogWillDisappear];
      [UIView beginAnimations:nil context:nil];
      [UIView setAnimationDuration:kTransitionDuration];
      self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
      [UIView setAnimationDelegate:self];
      [self performSelector:@selector(hidden)];
      [UIView commitAnimations];
    
    [[NSUserDefaults standardUserDefaults]setValue:@"Secondtime" forKey:@"Terms"];
    [[NSUserDefaults standardUserDefaults]synchronize];

      
}
    
-(void)hidden{
    [self release];

}
- (void)cancel {
  [self dismiss:YES ];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {


  if (self = [super initWithFrame:CGRectMake(20, 20, 280, 410)]) {
      [self drawRect:self.frame];
  
    self.backgroundColor = [UIColor clearColor];
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeRedraw;
   
    UIImage* closeImage = [UIImage imageNamed:@"btnAccept.png"];
    
    UIColor* color = [UIColor colorWithRed:167.0/255 green:184.0/255 blue:216.0/255 alpha:1];
    _closeButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [_closeButton setImage:closeImage forState:UIControlStateNormal];
    [_closeButton setTitleColor:color forState:UIControlStateNormal];
    [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_closeButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
	if ([_closeButton respondsToSelector:@selector(titleLabel)]) {
		_closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	} else { // This triggers a deprecation warning but at least it will work on OS 2.x
		//_closeButton.font = [UIFont boldSystemFontOfSize:12];
	}
	//_closeButton.showsTouchWhenHighlighted = YES;
    _closeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:_closeButton];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.text = kDefaultTitle;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin
      | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:_titleLabel];
        
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 40, 260,320)];
    _webView.delegate = self;
      
      NSString *path = [[NSBundle mainBundle] pathForResource:@"Terms & Conditions" ofType:@"doc"];
      NSURL *targetURL = [NSURL fileURLWithPath:path];
      NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
      _webView.scalesPageToFit=TRUE;
      [_webView loadRequest:request];
      _webView.backgroundColor =[UIColor blackColor];
      _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
      [self addSubview:_webView];

    }
  return self;
}

- (void)dealloc {
  _webView.delegate = nil;
  [_webView release];
//  [_spinner release];
//  [_titleLabel release];
//  [_iconView release];
  [_closeButton release];
//  [_loadingURL release];
//  [_session release];
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIView

- (void)drawRect:(CGRect)rect {
  CGRect grayRect = CGRectOffset(rect,-0.5, -0.5);
  [self drawRect:grayRect fill:kBorderGray radius:10];

  CGRect headerRect = CGRectMake(
    ceil(rect.origin.x + kBorderWidth), ceil(rect.origin.y + kBorderWidth),
    rect.size.width - kBorderWidth*2, _titleLabel.frame.size.height);
  [self drawRect:headerRect fill:kFacebookBlue radius:0];

    [self show];
}



- (NSString*)title {
  return _titleLabel.text;
}

- (void)setTitle:(NSString*)title {
  _titleLabel.text = title;
}

- (void)show {
  [self load];
  CGFloat innerWidth = self.frame.size.width - (kBorderWidth+1)*2;  

    [_titleLabel sizeToFit];
    [_closeButton sizeToFit];

  _titleLabel.frame = CGRectMake( kBorderWidth + kTitleMarginX + kTitleMarginX, kBorderWidth, innerWidth - (_titleLabel.frame.size.height  + kTitleMarginX*2),
    _titleLabel.frame.size.height + kTitleMarginY*2);
  
  _closeButton.frame = CGRectMake(30, kBorderWidth+_webView.frame.size.height+32, _webView.frame.size.width-30, _titleLabel.frame.size.height+20);
  
    [self dialogWillAppear];
    
  self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:kTransitionDuration];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
  self.transform = CGAffineTransformScale([self transformForOrientation], 1.1, 1.1);
  [UIView commitAnimations];

}

- (void)dismissWithSuccess:(BOOL)success animated:(BOOL)animated {
  if (success) {
      
  [self dismiss:animated];
  
  }
}

- (void)load {
  // Intended for subclasses to override
}


- (void)dialogWillAppear {
}

- (void)dialogWillDisappear {
}

- (void)dialogDidSucceed:(NSURL*)url {
  [self dismissWithSuccess:YES animated:YES];
}

@end
