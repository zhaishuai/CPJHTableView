//
//  CPJHTableView.m
//  CPJHTableView
//
//  Created by shuaizhai on 5/13/16.
//  Copyright © 2016 cpj. All rights reserved.
//

#import "CPJHTableView.h"

@interface CPJHTableView()

@property (nonatomic) NSMutableDictionary *cellMetaClassDic;
@property (nonatomic) NSMutableArray      *cellPosArray;
@property (nonatomic) NSIndexPath         *leftIndexPath;

@end

@implementation CPJHTableView
@dynamic delegate;
@synthesize leftIndexPath = _leftIndexPath;

- (instancetype)init{
    if(self = [super init]){
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initialize];
    }
    return self;
}

- (void)initialize{
    [self reloadData];
}

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier{
    [self.cellMetaClassDic setObject:nib forKey:identifier];
}


- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier{
    [self.cellMetaClassDic setObject:cellClass forKey:identifier];
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
                                          forIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}

- (void)reloadData{
    [self.cellPosArray removeAllObjects];
    CGFloat   contentWidth = 0;
    NSInteger numberOfRowsInsection = 0;
    if([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]){
        numberOfRowsInsection = [self.dataSource tableView:self numberOfRowsInSection:0];
    }
    if([self.delegate respondsToSelector:@selector(tableView:widthForRowAtIndexPath:)]){
        for(int row = 0; row < numberOfRowsInsection ; row++){
            @autoreleasepool {
                CGFloat heightOfCell = [self.delegate tableView:self widthForRowAtIndexPath:[NSIndexPath indexPathForItem:row inSection:00]];
                [self.cellPosArray addObject:[NSNumber numberWithDouble:contentWidth]];
                contentWidth += heightOfCell;
                
            }
        }
    }
    self.contentSize = CGSizeMake(contentWidth, self.frame.size.height);
    
}



- (void)leftIndexPathWithContentOffset:(CGPoint)contentOffset{
    
    while(contentOffset.x > [[self.cellPosArray objectAtIndex:self.leftIndexPath.row] doubleValue] + [self.delegate tableView:self widthForRowAtIndexPath:self.leftIndexPath] && self.leftIndexPath.row < self.cellPosArray.count){
        self.leftIndexPath = [NSIndexPath indexPathForRow:self.leftIndexPath.row+1 inSection:self.leftIndexPath.section];
    }
    
    while(contentOffset.x < [[self.cellPosArray objectAtIndex:self.leftIndexPath.row] doubleValue] && self.leftIndexPath.row > 0){
        self.leftIndexPath = [NSIndexPath indexPathForRow:self.leftIndexPath.row-1 inSection:self.leftIndexPath.section];
    }
//    NSLog(@"row: %ld", self.leftIndexPath.row);
    
}



- (void)layoutCells{
    UITableViewCell *cell;
    if([self.dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]){
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.leftIndexPath.row inSection:self.leftIndexPath.section];
        while(indexPath.row > 0 && indexPath.row < self.cellPosArray.count){
            
            cell = [self.dataSource tableView:self cellForRowAtIndexPath:self.leftIndexPath];
            cell.frame = CGRectMake([self.cellPosArray[self.leftIndexPath.row] doubleValue], 0, [self.delegate tableView:self widthForRowAtIndexPath:self.leftIndexPath], self.frame.size.height);
            
            if(([self.cellPosArray[self.leftIndexPath.row] doubleValue] + [self.delegate tableView:self widthForRowAtIndexPath:self.leftIndexPath]) > self.contentOffset.x + self.frame.size.width){
                break;
            }
        }
        
    }
    
    
}

- (void)setContentOffset:(CGPoint)contentOffset{
    
    super.contentOffset = contentOffset;
    if(self.cellPosArray.count == 0)
        return;
    [self leftIndexPathWithContentOffset:contentOffset];
   
}


- (NSMutableArray *)cellPosArray{
    if(!_cellPosArray){
        _cellPosArray = [NSMutableArray new];
    }
    return _cellPosArray;
}

- (NSMutableDictionary *)cellMetaClassDic{
    if(!_cellMetaClassDic){
        _cellMetaClassDic = [NSMutableDictionary new];
    }
    return _cellMetaClassDic;
}

- (void)setLeftIndexPath:(NSIndexPath *)leftIndexPath{
    if(_leftIndexPath.row != leftIndexPath.row || _leftIndexPath.section != leftIndexPath.section){
        _leftIndexPath = leftIndexPath;
        [self layoutCells];
        NSLog(@"row: %ld", self.leftIndexPath.row);
    }
}

- (NSIndexPath *)leftIndexPath{
    if(!_leftIndexPath){
        _leftIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _leftIndexPath;
}

@end
