//
//  WVTableViewCell.h
//  WebVister
//
//  Created by KennethDai on 7/26/16.
//  Copyright © 2016 KennethDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WVTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UIView *mainCellView;



- (void)loadViewWithUrl:(NSString *)urlStr;
- (void)isWebViewHidden:(BOOL)isHidden;
@end
