//
//  OverlayCVFlowLayout.m
//  CathayInterViewProject
//
//  Created by Tzu_Chen on 24.02.21.
//  Copyright © 2021 Tzu-Chen. All rights reserved.
//

#import "OverlayCVFlowLayout.h"

@implementation OverlayCVFlowLayout

-(void)prepareLayout{
    [super prepareLayout];
    if (self.collectionView == nil) {
        return;
    }
    
    self.collectionView.showsVerticalScrollIndicator = false;
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.minimumLineSpacing = 0;
}


- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    if ([super layoutAttributesForElementsInRect:rect] == nil) {
        return nil;
    }

    if (self.isExpand == false) {
        //壓縮
         NSMutableArray * attributes = [NSMutableArray array];
           for (UICollectionViewLayoutAttributes * attribute in [super layoutAttributesForElementsInRect:rect]) {
               
               CGFloat minY = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
               CGFloat maxY = attribute.frame.origin.y;
               
               CGPoint newOrigin = CGPointMake(attribute.frame.origin.x, MAX(minY, maxY));
               if (attribute.indexPath.row == 0) {
                    attribute.frame = CGRectMake(newOrigin.x , newOrigin.y, attribute.frame.size.width , attribute.frame.size.height);
               }else{
                   attribute.frame = CGRectMake(newOrigin.x , newOrigin.y, attribute.frame.size.width * 0.935, attribute.frame.size.height);
                   [attribute setCenter:CGPointMake(self.collectionView.frame.size.width / 2, minY + 60)];
                   attribute.zIndex = -attribute.indexPath.row;
               }
               [attributes addObject:attribute];

           }
           return attributes;
    }else {
        //展開
        NSMutableArray * attributes = [NSMutableArray array];
        for (UICollectionViewLayoutAttributes * attribute in [super layoutAttributesForElementsInRect:rect]) {
           
            CGFloat maxY = attribute.frame.size.height * attribute.indexPath.row;
            CGPoint newOrigin = CGPointMake(self.collectionView.frame.origin.x,maxY);
            
            if (attribute.indexPath.row == 0) {
                attribute.frame = CGRectMake(newOrigin.x , newOrigin.y, attribute.frame.size.width , attribute.frame.size.height);
            }else{
                attribute.zIndex = -attribute.indexPath.row;
                attribute.frame = CGRectMake(newOrigin.x , newOrigin.y, self.collectionView.frame.size.width, attribute.frame.size.height);
            }
            [attributes addObject:attribute];
        }
        return [super layoutAttributesForElementsInRect:rect];
    }
    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return true;
}

@end
