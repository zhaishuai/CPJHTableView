//
//  CPJHTableView.h
//  CPJHTableView
//
//  Created by shuaizhai on 5/13/16.
//  Copyright © 2016 cpj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPJHTableView;

@protocol CPJHTableViewDataSource <NSObject>

@required

- (NSInteger)tableView:(CPJHTableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(CPJHTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional


@end

@protocol CPJHTableViewDelegate <NSObject, UIScrollViewDelegate>

@required


@optional

- (CGFloat)tableView:(CPJHTableView *)tableView widthForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface CPJHTableView : UIScrollView

@property (nonatomic, weak) id<CPJHTableViewDataSource> dataSource;
@property (nonatomic, weak) id<CPJHTableViewDelegate>   delegate;

- (void)registerNib:(UINib *)nib
forCellReuseIdentifier:(NSString *)identifier;

- (void)registerClass:(Class)cellClass
forCellReuseIdentifier:(NSString *)identifier;

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
                                          forIndexPath:(NSIndexPath *)indexPath;
- (void)reloadData;


@end
